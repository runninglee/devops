#!/bin/bash

#变量名称声明等号之间不能有空格
name="crazy lee"

#输出变量使用双引号 饮用变量使用$
echo "my name is $name"

#声明后缀的文件后缀
so=".sql"

#合并字符串 使用双引号引用变量
filename=`date +%Y-%m-%d-%k-%M`"$so"

#定义动态变量
echo "$filename"gooo
