#makefile学习
## **变量的使用**
 `:=` 操作符可以使当前变量只能使用上述已经定义的变量如

	x := foo 
	y := $(x) bar 
	x := later

等价于

	y := foo bar
	x := later

`?=`操作符的意思是如果变量之前未被定义则将其定义为某个值，否则就什么都不做具体如下所示：

	FOO ?= bar

等价于

	ifeq ($(origin FOO), undefined)
    FOO = bar
	endif

`$(var:a=b)`操作符的意思是把变量“var”中所有以“a”字串“结尾”的“a”替换成“b”字串如：

	foo := a.o b.o c.o
	bar := $(foo:.o=.c）

这个示例中，我们先定义了一个`$(foo)`变量而第二行的意思是把` $(foo)` 中所有以 `.o` 字串“结尾”全部替换成 `.c` ，所以我们的 `$(bar)` 的值就是“a.c b.c c.c”。

	x = y
	y = z
	a := $($(x))
可以把变量的值再当成变量

使用 `+=` 操作符给变量追加值，如：

	objects = main.o foo.o bar.o utils.o
	objects += another.o
于是，我们的 `$(objects) `值变成：“main.o foo.o bar.o utils.o another.o”

makefile变量区的代码如下所示：

	#变量区
	Src_Dir   := src
	Build_Dir := build
	Src       := $(wildcard  $(Src_Dir)/*.c)
	Obj       := $(patsubst  $(Src_Dir)/%.c, $(Build_Dir)/%.o, $(Src))

其中`wildcard` 是 GNU make 的一个函数，作用是在文件系统里按通配符模式展开。`patsubst` 是“pattern-substitute”的缩写，也是 make 的函数。
格式：$(patsubst 模式,替换式,文本列表)

输出具体内容如图所示

![](./1.png)

Makefile中通配符的用法：

	%.o表示任意.o文件
	%.c表示任意.c文件
	$@表示目标
	$<表示第一个依赖文件
	$^表示所有的依赖文件 

## 条件变量
具体使用代码如下所示：

	ARCH        ?= x86_64   
	ifeq ($(ARCH),x86_64)
		CC        := gcc
  		TARGET    := build/app-x86_64
	else ifeq ($(ARCH),arm64)
  		CC        := aarch64-linux-gnu-gcc   
  		TARGET    := build/app-arm64

	endif
根据架构判断用哪种交叉编译以及最后编译的目标文件

## 伪目标定义以及显示规则编写

	.PHONY: all clean help
	all: $(TARGET)
	$(TARGET): $(OBJ) | $(BUILD_DIR)/$(ARCH)
		$(CC) $^ -o $@
	$(BUILD_DIR)/$(ARCH)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)/$(ARCH)
		$(CC) $(CFLAGS) -c $< -o $@
定义伪目标位`all` ,`clean`以及`help`由于“伪目标”不是文件，所以make无法生成它的依赖关系和决定它是否要执行。所以执行到all之后默认编译所有目标文件。

`|` 后面的目录是只要求目录存在，不会因为它的时间戳变化就触发重新链接。

## 辅助函数定义

	$(BUILD_DIR)/$(ARCH):
		mkdir -p $@

	clean:
		rm -rf $(BUILD_DIR)
第一个辅助函数是用于创建文件夹，而`clean`命令用于清除生成的文件

#shell脚本学习

##基础学习

使用一个定义过的变量，只要在变量名前面加美元符号即可，如：

	your_name="qinjx"
	echo $your_name
	echo ${your_name}

使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

	#!/bin/bash
	
	myUrl="https://www.google.com"
	readonly myUrl
	myUrl="https://www.runoob.com"
使用 unset 命令可以删除变量。语法：

	unset variable_name
##变量定义

字符串变量： 在 Shell中，变量通常被视为字符串。

你可以使用单引号 `'` 或双引号 `"` 来定义字符串，例如：

	my_string='Hello, World!'
整数变量： 在一些Shell中，你可以使用 declare 或 typeset 命令来声明整数变量。

这样的变量只包含整数值，例如：

	declare -i my_integer=42
数组变量： Shell 也支持数组，允许你在一个变量中存储多个值。

数组可以是整数索引数组或关联数组，以下是一个简单的整数索引数组的例子：

	my_array=(1 2 3 4 5)
或者关联数组：

	declare -A associative_array
	associative_array["name"]="John"
	associative_array["age"]=30
##shell字符串
字符串是shell编程中最常用最有用的数据类型（除了数字和字符串，也没啥其它类型好用了），字符串可以用单引号，也可以用双引号，也可以不用引号。`str='this is a string'`

**单引号字符串的限制：**

单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；

单引号字符串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

**双引号的优点：**

双引号里可以有变量

双引号里可以出现转义字符
###获取字符串长度

	string="abcd"
	echo ${#string}   # 输出 4

###提取字符串

	string="runoob is a great site"
	echo ${string:1:4} # 输出 unoo

###查找子字符串

	string="runoob is a great site"
	echo `expr index "$string" io`  # 输出 4

以上脚本中 ` 是反引号，而不是单引号 ' ，查找字符 i 或 o 的位置(哪个字母先出现就计算哪个)。

##shell数组
bash支持一维数组（不支持多维数组），并且没有限定数组的大小。
###定义数组
在 Shell 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：

	array_name=(value0 value1 value2 value3)

还可以单独定义数组的各个分量：

	array_name[0]=value0
	array_name[1]=value1
	array_name[n]=valuen

###读取数组
读取数组元素值的一般格式是：

	valuen=${array_name[n]}

使用 `@` 符号可以获取数组中的所有元素，例如：

	echo ${array_name[@]}
###获取数组长度
获取数组长度的方法与获取字符串长度的方法相同，例如：

	# 取得数组元素的个数
	length=${#array_name[@]}
	# 或者
	length=${#array_name[*]}
	# 取得数组单个元素的长度
	length=${#array_name[n]}

##shell传递参数

我们可以在执行 Shell 脚本时，向脚本传递参数，脚本内获取参数的格式为 $n，n 代表一个数字，1 为执行脚本的第一个参数，2 为执行脚本的第二个参数。

例如可以使用 `$1、$2 `等来引用传递给脚本的参数，其中 `$1` 表示第一个参数，`$2 `表示第二个参数，依此类推。

	#!/bin/bash
	echo "Shell 传递参数实例！";
	echo "执行的文件名：$0";
	echo "第一个参数为：$1";
	echo "第二个参数为：$2";
	echo "第三个参数为：$3";

参数处理	说明

$#	传递到脚本的参数个数

$*	以一个单字符串显示所有向脚本传递的参数。
如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。

$$	脚本运行的当前进程ID号

$!	后台运行的最后一个进程的ID号

$@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。

$-	显示Shell使用的当前选项，与set命令功能相同。

$?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。

##shell数组

创建一个简单的数组 my_array：

	my_array=(A B "C" D)


##运算符

运算符	说明	举例

+加法	`expr $a + $b` 结果为 30。

-减法	`expr $a - $b` 结果为 -10。

*乘法	`expr $a \* $b` 结果为  200。

/除法	`expr $b / $a` 结果为 2。

%取余	`expr $b % $a` 结果为 0。

=赋值	a=$b 把变量 b 的值赋给 a。

==相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。

!=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。

完整的表达式要被 `` 包含，注意这个字符不是常用的单引号，在 Esc 键下边。

#猜数字大小代码

	#!/bin/bash
	  
	# 下限
	min=0;
	# 上限
	max=10;
	
	range=$((max - min + 1));
	# 生成上限与下限之间的随机数
	random_num=$(((RANDOM % range) + min));
	# 接受到CTRL + C 指令退出
	trap 'echo "游戏结束"; exit' INT
	
	while true; do
	        # 使用read函数接受输入
	        read -p "请输入猜测数字（1-10）：" num
	        if((num > random_num)); then
	                echo "输入的数过大"
	        elif ((num < random_num)); then
	                echo "输入的数过小"
	        else
	                echo "输入正确,答案是$random_num"
	                break
	        fi
	done
运行结果：

![guess_num](guess_num.png)

#查找包含关键字的文件
	
	#!/bin/bash
	
	# 定义要找的文件扩展名和关键字
	EXTENSION="txt"
	KEYWORD=$1
	RESULT_FILE="result.log"
	
	# 将结果保存到result.log中
	find ./workspace -type f -name "*.${EXTENSION}" -exec  grep -q "${KEYWORD}" {} \; -print > "${RESULT_FILE}"
	
	# 统计符合条件的文件数量
	FILE_COUNT=$(wc -l < "${RESULT_FILE}")
	
	# 如果有符合条件的文件，将其权限改为已读
	if [ ${FILE_COUNT} -gt 0 ] ; then
	        while IFS= read -r file; do
	                chmod 444 "$file"
	        done < "${RESULT_FILE}"
	fi
	
	# 输出操作完成以及处理文件的数量
	echo "操作完成"
	echo "一共处理了${FILE_COUNT}个文件"

关键代码`find ./workspace -type f -name "*.${EXTENSION}" -exec  grep -q "${KEYWORD}" {} \; -print > "${RESULT_FILE}"` 
其中`find ./workspace -type f -name "*.txt"`的意思是查找workspace文件夹下所有后缀为.txt的文件，`-exec grep -q "${KEYWORD}" {} \;`的意思是在找到符合条件的文件后执行grep命令查找是否包含关键字 `{}`表示在当前文件下 `\;`表示命令的结束 `-print > "${RESULT_FILE}"` 的意思是将符合条件的文件路径输出到result.log文件中。

运行结果：
![keyword](find_keyword.png)