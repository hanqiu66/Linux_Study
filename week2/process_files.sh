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

