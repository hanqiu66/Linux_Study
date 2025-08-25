<font size = 4>
<font face = "黑体">

#Linux开机流程

Linux kernel启动阶段主要分为三个阶段：硬件初始化、内核子系统启动和用户空间初始化。内核初始化会先调用内核初始化总入口`start_kernel()`函数(init/main.c)并且在log中输出版本信息

	8月 13 15:22:13 uuu-virtual-machine kernel: Linux version 5.15.0-139-generic (buildd@lcy02-amd64-067) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #149~20.04.1-Ubuntu SMP Wed Apr 16 08:29:56 UTC 2025 (Ubuntu 5.15.0-139.149~20.04.1-generic 5.15.178)

##硬件初始化
进入初始化函数后首先调用 `setup_arch()`函数（arch/x86/kernel/setup.c）对硬件架构进行初始化并在log中输出

	BIOS-provided physical RAM map: ...
完成硬件初始化

##内存子系统初始化
在完成内核初始化后会调用`mm_init()`函数进行内存子系统初始化，对应的在log中输出

	8月 13 15:22:13 uuu-virtual-machine kernel: Memory: 3869364K/4193716K available (16393K kernel code, 4396K rwdata, 10888K rodata, 3372K init, 18700K bss, 324092K reserved, 0K cma-reserved)

后续分别调用`sched_init()`函数对进程调度器初始化,log显示

	8月 13 15:22:13 uuu-virtual-machine kernel: rcu: Hierarchical RCU implementation.

`rcu_init()`对RCU锁机制初始化，`pci_init()`对PCI总线初始化，`driver_init()`函数对设备驱动核心初始化，最后`vfs_caches_init() `对文件系统缓存初始化

调用`rest_init()`启动用户态初始化进程，其中调用`kernel_init()`函数启动第一个用户进程并且在该函数下调用`mount_root()`函数挂载根文件系统至此完成对内核启动log显示

	8月 13 15:22:13 uuu-virtual-machine kernel: EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
。具体的执行顺序与依赖关系如下所示。


![process](kernel_process.png)

##用户空间初始化

![user_process](user_process.png)

systemd_main()：用户空间初始化的入口，依赖于内核已启动init进程并切换到根文件系统（前置依赖：内核rest_init()完成）。log显示

	8月 13 15:22:13 uuu-virtual-machine systemd[1]: systemd 245.4-4ubuntu3.24 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)


manager_init()：初始化服务管理器，首先启动日志服务（journald_init()）和设备管理（udev_init()），因为后续所有服务的日志需要记录，且设备管理需识别用户态硬件（如鼠标、键盘）。

mount_setup()与swap_activate()：挂载非根文件系统（如/boot/efi）和激活交换分区，依赖于文件系统驱动（内核态已初始化）和udev识别的存储设备。

service_start()：启动基础服务，时间同步（ntpd）和 DNS 解析（resolved）需在网络服务前启动（网络依赖时间同步和域名解析）；安全策略（apparmor）需在应用程序启动前加载，限制进程权限。

start_desktop()：启动图形环境，依赖于所有基础服务（网络、设备、安全）就绪，且显卡驱动（内核态vmwgfx）已加载，确保图形输出正常。

#字符驱动编写

首先一个驱动最重要的是：驱动的初始化，所以先从驱动初始化进行编写

驱动初始化一共包括两步：1.从内核分配缓存区 2.注册字符设备

##分配缓存区
首先定义初始化函数`static int __init char_dev_init(void)`其中__init是 Linux 内核的一个特殊宏（定义在<linux/init.h>中），用于标记驱动的初始化函数，告诉内核该函数仅在模块加载时执行一次，执行后会释放内存。
内存分配部分代码为：

	int ret; //用于记录返回值

    //分配缓存区
    buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);                      //kmalloc()函数为内核提供的内存分配函数，GFP_KERNEL为分配标志，表示这是内核正常分配
    
    //错误处理，若分配失败buffer为NULL
    if(!buffer){
        printk(KERN_ERR "char_dev: Failed to allocate memory\n");  //printk()函数作用相当于printf()这是专门用于内核模块向系统日志输出信息。
        return -ENOMEM;
    }

    memset(buffer, 0, BUFFER_SIZE);
其中，ret用于记录返回值，kmalloc()函数为内核提供的内存分配函数，GFP_KERNEL为分配标志，表示这是内核正常分配，若分配失败buffer为NULL使用内核打印函数printk()打印错误到KERN_ERR中，若成功分配将buffer缓存区清空。

##注册字符设备
这部分代码如下所示：

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
首先用MKDEV()将主设备号和次设备号组合成dev_t类型，然后通过register_chrdev_region()函数注册设备。初始化cdev结构并添加到系统中，利用cdev_init()函数用于初始化char_dev结构体并且绑定操作集，其中fops定义如下所示：

	static struct file_operations fops = {
    .open = char_open,
    .release = char_close,
    .read = char_read,
    .write = char_write,
    .owner = THIS_MODULE,
	};
编写完函数入口函数，编写出口函数，该函数用于在退出驱动后清理已分配内存避免内存泄漏。具体代码如下所示：

	static void __exit char_driver_exit(void){
    //清理资源
    cdev_del(&char_cdev);
    unregister_chrdev_region(dev_num, 1);
    kfree(buffer);

    printk(KERN_INFO "char_dev: Driver exiten\n");
	}
##操作函数编写
操作函数分为四个部分：open、close、read和write函数

open和close分别由内核调用对应的函数即可完成因此在函数编写上，在调用时输出信息到日志中代码如下所示：

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

read函数编写，具体代码如下所示：

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
首先参数部分`struct file *file`：内核维护的文件对象，记录文件打开状态。

`const char __user *user_buf`：用户空间的缓冲区指针（__user标记表明这是用户空间地址，内核不能直接访问），存储要写入的数据。

`size_t count`：用户请求写入的字节数（例如echo命令传递的字符串长度）。

`loff_t *offset`：文件偏移量指针，记录当前写入位置。

首先计算需要读取多少字节的内容保存在bytes_read中，通过文件偏移量指针判断文件中是否还有内容，后续通过该变量表示需要从内核空间拷贝多少内存到用户空间，最后更新文件偏移量。

write函数编写，具体代码如下所示：

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

利用bytes_write记录需要写入多少字节，后续使用此用于计算需要从用户空间拷贝多少内容到内核空间，每次写入内容都将文件偏移量更新至缓存区头部。

完整代码如下所示：

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
	
	
	static int __init char_dev_init(void){
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

具体运行结果如图所示

![insmod](insmod.png)

![driver_result](driver_result.png)

#升级驱动支持IOCTL和动态分配缓冲区

在之前驱动的基础上编写新的`char_ioctl`函数用于处理用户动态调整缓存区大小命令具体代码如下所示：

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

并且在驱动初始化时添加代码使其初始化时自动创建设备节点

	// 4. 创建设备类（用于自动创建设备节点）
	    char_class = class_create(THIS_MODULE, DEVICE_NAME);
	    if (IS_ERR(char_class)) {
	        ret = PTR_ERR(char_class);
	        printk(KERN_ERR "Failed to create class (ret: %d)\n", ret);
	        goto err_class;
	    }
	
	    // 5. 创建设备节点（/dev/dynamic_char）
	    device_create(char_class, NULL, dev_num, NULL, DEVICE_NAME);
	    printk(KERN_INFO "%s: Driver initialized\n", DEVICE_NAME);
	    return 0;

编写测试代码：

	#include <stdio.h>
	#include <fcntl.h>
	#include <sys/ioctl.h>
	#include <stdlib.h>
	#include <string.h>
	#include <unistd.h>
	
	// 需与驱动中定义一致
	#define CHAR_MAGIC 'c'
	#define CHAR_IOCTL_SET_SIZE _IOW(CHAR_MAGIC, 0, int)
	
	int main() {
	    int fd;
	    int new_size = 2048;  // 新缓冲区大小（2KB）
	    char w_buf[1024] = "hello, dynamic buffer!";
	    char r_buf[1024] = {0};
	
	    // 打开设备
	    fd = open("~/dev/dynamic_char", O_RDWR);
	    if (fd < 0) {
	        perror("open failed");
	        return -1;
	    }
	
	    // 1. 测试IOCTL调整缓冲区大小
	    if (ioctl(fd, CHAR_IOCTL_SET_SIZE, &new_size) < 0) {
	        perror("ioctl set size failed");
	        close(fd);
	        return -1;
	    }
	    printf("IOCTL: Set buffer size to %d bytes\n", new_size);
	
	    // 2. 写入数据
	    if (write(fd, w_buf, strlen(w_buf)) < 0) {
	        perror("write failed");
	        close(fd);
	        return -1;
	    }
	    printf("Write: %s\n", w_buf);
	
	    // 3. 读取数据
	    if (read(fd, r_buf, sizeof(r_buf)) < 0) {
	        perror("read failed");
	        close(fd);
	        return -1;
	    }
	    printf("Read: %s\n", r_buf);
	
	    close(fd);
	    return 0;
	}
测试结果如图：

![test](test_ioctl.png)

#驱动嵌入源码

首先修改驱动代码，因为需要随着Linux开机自启动所以不需要模块初始化。因此需要将代码原本的模块宏删除并且使用适合的初始化宏。代码如下：

	// 移除 module_init(char_driver_init);
	// 添加内核初始化调用（优先级20，数值越小优先级越高）
	device_initcall_sync(char_driver_init);  // 适合设备驱动的初始化宏
	// 移除以下模块宏
	// MODULE_LICENSE("GPL");
	// MODULE_AUTHOR("Your Name");
	// MODULE_DESCRIPTION(...);

修改完毕之后将驱动代码放入内核源码树路径为`~/linux/drivers/char/`
并且修改对应路径下的Kconfig文件添加如下内容：

	# 自定义驱动配置选项
	config MY_DYNAMIC_CHAR
	    tristate "Dynamic Buffer Char Driver with IOCTL"  # 驱动名称（make menuconfig中显示）
	    default y  # 默认编译进内核（y=编译进内核，m=编译为模块，n=不编译）
	    help
	      This is a char driver with dynamic buffer and IOCTL support.
	      Say Y here to compile it into the kernel, or M to compile it as a module.
最后修改对应目录下的Makefile文件添加如下代码：

	# 编译自定义驱动（obj-y表示编译进内核，obj-m表示编译为模块）
	obj-$(CONFIG_MY_DYNAMIC_CHAR) += char_driver.o
完成这些操作后重新编译内核在qemu中进行仿真测试具体效果如下所示：

![dmesg](dmesg.png)
至此完成开机自启动以及自动创建对应的设备的功能