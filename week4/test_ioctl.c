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
    fd = open("/dev/dynamic_char", O_RDWR);
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