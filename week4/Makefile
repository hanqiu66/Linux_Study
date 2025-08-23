obj-m += char_driver_i.o
KERNELDIR ?= ~/linux  # 替换为你的ARM内核源码根目录
ARCH := arm
CROSS_COMPILE := arm-linux-gnueabihf-  # 替换为你的交叉编译工具链前缀

PWD := $(shell pwd)
default:
	$(MAKE) -C $(KERNELDIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) modules
clean:
	$(MAKE) -C $(KERNELDIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) modules clean
