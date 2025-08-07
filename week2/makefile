# 默认架构
ARCH        ?= x86_64

# 根据架构切换编译器前缀
ifeq ($(ARCH),x86_64)
  CC        := gcc
  TARGET    := build/app-x86_64
else ifeq ($(ARCH),arm64)
  CC        := aarch64-linux-gnu-gcc
  TARGET    := build/app-arm64
endif

SRC_DIR     := src
BUILD_DIR   := build
SRC         := $(wildcard $(SRC_DIR)/*.c)
OBJ         := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/$(ARCH)/%.o,$(SRC))

CFLAGS      := -Wall -O2
LDFLAGS     :=

.PHONY: all clean help

# 同时生成两种架构
all: $(TARGET)

# 链接最终可执行文件
$(TARGET): $(OBJ) | $(BUILD_DIR)/$(ARCH)
	$(CC) $^ -o $@

# 编译每个 .o
$(BUILD_DIR)/$(ARCH)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)/$(ARCH)
	$(CC) $(CFLAGS) -c $< -o $@

# 确保中间目录存在
$(BUILD_DIR)/$(ARCH):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)

help:
	@echo "make         # 同时编 x86_64 + arm64"
	@echo "make ARCH=x86_64"
	@echo "make ARCH=arm64"
