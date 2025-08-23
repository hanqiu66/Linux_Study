#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <linux/ioctl.h>
#include <linux/slab.h>
#include <linux/mutex.h>

// 设备相关信息
#define DEVICE_NAME "dynamic_char"  // 设备名称
#define DEVICE_MINOR 0              // 次设备号
#define DEVICE_COUNT 1              // 设备数量

// IOCTL命令定义（避免与其他设备冲突，使用专属魔数）
#define CHAR_MAGIC 'c'              // 魔数（自定义）
// 命令：设置缓冲区大小（_IOW：用户向内核写数据，第三个参数为int类型）
#define CHAR_IOCTL_SET_SIZE _IOW(CHAR_MAGIC, 0, int)
// 最大缓冲区限制（防止内存滥用，可自定义）
#define MAX_BUFFER_SIZE (1024 * 1024)  // 1MB
#define DEFAULT_BUFFER_SIZE 1024       // 默认初始大小（1KB）

// 全局变量（设备状态）
static dev_t dev_num;                // 设备号
static struct cdev char_cdev;        // cdev结构体
static struct class *char_class;     // 设备类

// 缓冲区相关（动态管理）
static char *buffer;                 // 缓冲区指针（动态分配）
static int buffer_size;              // 当前缓冲区大小
static int buffer_len;               // 当前缓冲区数据长度
static loff_t file_offset;           // 文件偏移量（替代原offset指针）

// 并发控制（防止读写/IOCTL同时操作缓冲区）
static struct mutex buffer_mutex;    // 互斥锁

// 设备操作函数声明
static int char_open(struct inode *inode, struct file *file);
static int char_release(struct inode *inode, struct file *file);
static ssize_t char_read(struct file *file, char __user *user_buf, size_t count, loff_t *offset);
static ssize_t char_write(struct file *file, const char __user *user_buf, size_t count, loff_t *offset);
static long char_ioctl(struct file *file, unsigned int cmd, unsigned long arg);

// 文件操作函数集
static const struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = char_open,
    .release = char_release,
    .read = char_read,
    .write = char_write,
    .unlocked_ioctl = char_ioctl,  // IOCTL接口（内核2.6.36+推荐）
};

// 初始化缓冲区（返回0成功，负数失败）
static int buffer_init(int init_size) {
    // 检查初始大小合法性
    if (init_size <= 0 || init_size > MAX_BUFFER_SIZE) {
        printk(KERN_ERR "Invalid buffer size (must be 1~%d)\n", MAX_BUFFER_SIZE);
        return -EINVAL;
    }

    // 分配内存（GFP_KERNEL：可睡眠，适合进程上下文）
    buffer = kmalloc(init_size, GFP_KERNEL);
    if (!buffer) {
        printk(KERN_ERR "Failed to allocate buffer (size: %d)\n", init_size);
        return -ENOMEM;
    }

    // 初始化缓冲区状态
    buffer_size = init_size;
    buffer_len = 0;
    file_offset = 0;
    memset(buffer, 0, buffer_size);  // 清空缓冲区
    printk(KERN_INFO "Buffer initialized (size: %d)\n", buffer_size);
    return 0;
}

// 调整缓冲区大小（返回0成功，负数失败）
static int buffer_resize(int new_size) {
    char *new_buffer;
    int copy_len;

    // 检查新大小合法性
    if (new_size <= 0 || new_size > MAX_BUFFER_SIZE) {
        printk(KERN_ERR "Invalid new size (must be 1~%d)\n", MAX_BUFFER_SIZE);
        return -EINVAL;
    }

    // 若大小不变，直接返回
    if (new_size == buffer_size) {
        return 0;
    }

    // 分配新缓冲区
    new_buffer = kmalloc(new_size, GFP_KERNEL);
    if (!new_buffer) {
        printk(KERN_ERR "Failed to allocate new buffer (size: %d)\n", new_size);
        return -ENOMEM;
    }

    // 拷贝旧数据（若新缓冲区更小，截断数据；若更大，补0）
    copy_len = (new_size < buffer_len) ? new_size : buffer_len;
    if (copy_len > 0) {
        memcpy(new_buffer, buffer, copy_len);  // 拷贝有效数据
    }
    memset(new_buffer + copy_len, 0, new_size - copy_len);  // 剩余空间清0

    // 释放旧缓冲区，更新指针和状态
    kfree(buffer);
    buffer = new_buffer;
    buffer_size = new_size;
    buffer_len = copy_len;  // 数据长度可能被截断
    file_offset = 0;        // 重置偏移量（避免旧偏移量超出新缓冲区）

    printk(KERN_INFO "Buffer resized (old: %d, new: %d, data kept: %d)\n",
           buffer_size, new_size, copy_len);
    return 0;
}

// 打开设备
static int char_open(struct inode *inode, struct file *file) {
    // 首次打开时初始化缓冲区（若未初始化）
    if (!buffer) {
        int ret = buffer_init(DEFAULT_BUFFER_SIZE);
        if (ret != 0) {
            return ret;
        }
    }
    printk(KERN_INFO "%s: Device opened\n", DEVICE_NAME);
    return 0;
}

// 关闭设备
static int char_release(struct inode *inode, struct file *file) {
    // 此处不释放缓冲区（保持数据，支持多次打开；若需关闭即释放，可在此处kfree）
    printk(KERN_INFO "%s: Device closed\n", DEVICE_NAME);
    return 0;
}

// 读取数据（用户->内核）
static ssize_t char_read(struct file *file, char __user *user_buf, size_t count, loff_t *offset) {
    int bytes_read = 0;
    int ret;

    // 加锁：防止读取时IOCTL修改缓冲区
    if (mutex_lock_interruptible(&buffer_mutex) != 0) {
        return -ERESTARTSYS;  // 被信号中断，返回重试
    }

    // 检查是否已无数据可读
    if (file_offset >= buffer_len) {
        goto out;  // 直接解锁返回0
    }

    // 计算实际可读取字节数（不超过剩余数据和用户缓冲区）
    bytes_read = (count > buffer_len - file_offset) ? (buffer_len - file_offset) : count;

    // 从内核缓冲区拷贝到用户空间
    ret = copy_to_user(user_buf, buffer + file_offset, bytes_read);
    if (ret != 0) {
        bytes_read = -EFAULT;  // 拷贝失败
        goto out;
    }

    // 更新偏移量
    file_offset += bytes_read;
    printk(KERN_INFO "%s: Read %d bytes (offset: %lld)\n", DEVICE_NAME, bytes_read, file_offset);

out:
    mutex_unlock(&buffer_mutex);  // 解锁
    return bytes_read;
}

// 写入数据（内核->用户）
static ssize_t char_write(struct file *file, const char __user *user_buf, size_t count, loff_t *offset) {
    int bytes_write = 0;
    int ret;

    // 加锁：防止写入时IOCTL修改缓冲区
    if (mutex_lock_interruptible(&buffer_mutex) != 0) {
        return -ERESTARTSYS;
    }

    // 计算实际可写入字节数（不超过缓冲区剩余空间）
    bytes_write = (count > buffer_size - buffer_len) ? (buffer_size - buffer_len) : count;
    if (bytes_write <= 0) {
        printk(KERN_WARNING "%s: Buffer full (size: %d, used: %d)\n",
               DEVICE_NAME, buffer_size, buffer_len);
        goto out;
    }

    // 清空缓冲区（覆盖模式；若需追加，注释此行）
    memset(buffer, 0, buffer_size);
    buffer_len = 0;
    file_offset = 0;

    // 从用户空间拷贝数据到内核缓冲区
    ret = copy_from_user(buffer, user_buf, bytes_write);
    if (ret != 0) {
        bytes_write = -EFAULT;  // 拷贝失败
        goto out;
    }

    // 更新缓冲区数据长度
    buffer_len = bytes_write;
    printk(KERN_INFO "%s: Wrote %d bytes (total used: %d)\n", DEVICE_NAME, bytes_write, buffer_len);

out:
    mutex_unlock(&buffer_mutex);  // 解锁
    return bytes_write;
}

// IOCTL接口（处理用户命令）
static long char_ioctl(struct file *file, unsigned int cmd, unsigned long arg) {
    int new_size;
    int ret;

    // 检查命令合法性（魔数、命令号、参数类型）
    if (_IOC_TYPE(cmd) != CHAR_MAGIC) {
        return -ENOTTY;  // 魔数不匹配
    }
    if (_IOC_NR(cmd) != 0) {
        return -ENOTTY;  // 命令号不支持
    }
    if (_IOC_SIZE(cmd) != sizeof(int)) {
        return -EINVAL;  // 参数大小错误
    }

    // 加锁：防止调整大小时读写操作冲突
    if (mutex_lock_interruptible(&buffer_mutex) != 0) {
        return -ERESTARTSYS;
    }

    // 处理“设置缓冲区大小”命令
    if (cmd == CHAR_IOCTL_SET_SIZE) {
        // 从用户空间获取新大小（arg是用户空间int变量的地址）
        ret = copy_from_user(&new_size, (int __user *)arg, sizeof(int));
        if (ret != 0) {
            ret = -EFAULT;
            goto out;
        }

        // 调用调整大小函数
        ret = buffer_resize(new_size);
    }

out:
    mutex_unlock(&buffer_mutex);  // 解锁
    return ret;
}

// 驱动初始化
static int __init char_driver_init(void) {
    int ret;

    // 1. 初始化互斥锁
    mutex_init(&buffer_mutex);

    // 2. 分配设备号（动态分配主设备号）
    ret = alloc_chrdev_region(&dev_num, DEVICE_MINOR, DEVICE_COUNT, DEVICE_NAME);
    if (ret < 0) {
        printk(KERN_ERR "Failed to alloc chrdev region (ret: %d)\n", ret);
        goto err_alloc;
    }
    printk(KERN_INFO "Allocated dev num: %d:%d\n", MAJOR(dev_num), MINOR(dev_num));

    // 3. 初始化cdev并绑定操作函数
    cdev_init(&char_cdev, &fops);
    char_cdev.owner = THIS_MODULE;
    ret = cdev_add(&char_cdev, dev_num, DEVICE_COUNT);
    if (ret < 0) {
        printk(KERN_ERR "Failed to add cdev (ret: %d)\n", ret);
        goto err_cdev;
    }

    // 4. 创建设备类（用于自动创建设备节点）
    char_class = class_create(DEVICE_NAME);
    if (IS_ERR(char_class)) {
        ret = PTR_ERR(char_class);
        printk(KERN_ERR "Failed to create class (ret: %d)\n", ret);
        goto err_class;
    }

    // 5. 创建设备节点（/dev/dynamic_char）
    device_create(char_class, NULL, dev_num, NULL, DEVICE_NAME);
    printk(KERN_INFO "%s: Driver initialized\n", DEVICE_NAME);
    return 0;

    // 错误处理（反向释放资源）
err_class:
    cdev_del(&char_cdev);
err_cdev:
    unregister_chrdev_region(dev_num, DEVICE_COUNT);
err_alloc:
    mutex_destroy(&buffer_mutex);
    return ret;
}

// 驱动退出
static void __exit char_driver_exit(void) {
    // 释放设备资源
    device_destroy(char_class, dev_num);
    class_destroy(char_class);
    cdev_del(&char_cdev);
    unregister_chrdev_region(dev_num, DEVICE_COUNT);

    // 释放缓冲区
    if (buffer) {
        kfree(buffer);
        buffer = NULL;
        printk(KERN_INFO "Buffer freed (size: %d)\n", buffer_size);
    }

    // 销毁互斥锁
    mutex_destroy(&buffer_mutex);
    printk(KERN_INFO "%s: Driver exited\n", DEVICE_NAME);
}

// 模块入口/出口
module_init(char_driver_init);
module_exit(char_driver_exit);

// 模块信息
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("Dynamic Buffer Char Driver with IOCTL");
MODULE_ALIAS("dynamic_char");