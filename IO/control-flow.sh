#!/bin/bash

# 作者邮箱: <lihui870920@gmail.com>

# Created at 16/10/2 by HuiLee

# 基本语法使用

echo "IFIFIF"

name='foo'

#[]表达式需要空格分隔开
if [ $name != 'foo' ]
then
echo 'No'
elif [ $name == 'foo' ]
then
echo 'Yes'
fi


echo "FORFOR"
#[]列表以空格风格
for i in c r a z y l e e
do
echo "i 是 $i"
done

echo "WHILEWHILEWHILE"

i=1

while [ $i -le 10 ]
do
echo "当前的索引是：$i"
#$((express))表达式方式
i=$(($i+1))
done