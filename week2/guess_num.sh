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

