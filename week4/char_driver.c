#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <linux/slab.h>

#define BUFFER_SIZE 1024

#define MAJOR_NUM 20

#define DEV_NAME "char_dev" 

static char *buffer;
static dev_t dev_num;
static struct cdev char_cdev;
static int buffer_len = 0;

//打开设备
static int char_open(struct inode *inode, struct file *file){
    printk(KERN_INFO "char_dev: Device opened\n");
    return 0;
}

//关闭设备
static int char_close(struct inode *inode, struct file *file){
    printk(KERN_INFO "char_dev: Device closed\n");
    return 0;
}

//读文件
static ssize_t char_read(struct file *file, char __user *user_buf, size_t count, loff_t *offset){
    int bytes_read = 0;

    //如果到达缓存区末尾，返回0表示已经完成
    if(*offset >= buffer_len){
        return 0;
    }

    //计算实际可读字节数
    bytes_read = (count > buffer_len - *offset) ? (buffer_len - *offset) : count;

    if(copy_to_user(user_buf, buffer + *offset, bytes_read)){
        return -EFAULT;
    }

    //更新偏移量
    *offset += bytes_read;
    printk(KERN_INFO "char_dev: Read %d bytes\n", bytes_read);

    return bytes_read;
}

static ssize_t char_write(struct file *file, const char __user *user_buf, size_t count, loff_t *offset){
    int bytes_write = 0;

    //计算实际写入字节数
    bytes_write = (count > BUFFER_SIZE) ? BUFFER_SIZE : count;

    //清空缓存区
    memset(buffer, 0, BUFFER_SIZE);

    if(copy_from_user(buffer, user_buf, bytes_write)){
        return -EFAULT;
    }

    //更新缓存区长度和偏移量
    buffer_len += bytes_write;
    *offset = 0;        //每次写入都从缓存区头部开始

    printk(KERN_INFO "char_dev: Wrote %d bytes\n", bytes_write);
    return bytes_write;
}

static struct file_operations fops = {
    .open = char_open,
    .release = char_close,
    .read = char_read,
    .write = char_write,
    .owner = THIS_MODULE,

};


static int __init char_driver_init(void){
    int ret; //用于记录返回值

    //分配缓存区
    buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);                      //kmalloc()函数为内核提供的内存分配函数，GFP_KERNEL为分配标志，表示这是内核正常分配
    
    //错误处理，若分配失败buffer为NULL
    if(!buffer){
        printk(KERN_ERR "char_dev: Failed to allocate memory\n");  //printk()函数作用相当于printf()这是专门用于内核模块向系统日志输出信息。
        return -ENOMEM;
    }

    memset(buffer, 0, BUFFER_SIZE);

    //注册字符设备
    dev_num = MKDEV(MAJOR_NUM, 0);                                  //MKDEV()将主设备号和次设备号组合成dev_t类型
    ret = register_chrdev_region(dev_num, 1, DEV_NAME);             //通过register_chrdev_region()函数注册设备
    if(ret < 0){
        printk(KERN_ERR "char_dev: Failed to register device number\n");
        kfree(buffer);
        return ret;
    }

    //初始化cdev结构并添加到系统
    cdev_init(&char_cdev, &fops);                                    //cdev_init()函数用于初始化char_dev结构体并且绑定操作集
    ret = cdev_add(&char_cdev, dev_num, 1);
    if(ret < 0){
        printk(KERN_ERR "char_dev: Failed to add cdev\n");
        kfree(buffer);
        unregister_chrdev_region(dev_num, 1);
        return ret;
    }

    printk(KERN_INFO "char_dev: Driver initialized. Major number: %d\n", MAJOR_NUM);
    return 0;

}

static void __exit char_driver_exit(void){
    //清理资源
    cdev_del(&char_cdev);
    unregister_chrdev_region(dev_num, 1);
    kfree(buffer);

    printk(KERN_INFO "char_dev: Driver exiten\n");
}

// 模块注册
module_init(char_driver_init);
module_exit(char_driver_exit);

// 模块信息
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("A simple character driver with fixed size buffer");
MODULE_VERSION("1.0");
