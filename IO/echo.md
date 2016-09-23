### echo 

**标准输出**

echo [options] string

```
-E  不转义输出字符串
-e  默认启用转义字符
-n  输出结束后不换行

```

**demo**

echo －e "My name is Crazy\nlee"

echo -E "My name is Crazy\nlee"

echo -n "My name is Crazy\nlee"


**数据库简单备份**

```
#!/bin/bash

# 作者邮箱: <lihui870920@gmail.com>

# Created at 16/9/23 by Hui Lee

# 系统数据库备份

# 备份数据库名称
database="demo"

# 备份数据库用户
username="demo"

# 备份数据库密码
password="demo"

echo "您现在备份的数据是：$database"

# 数据库文件后缀名
so=".sql"

# 备份数据库文件名
filename=`date +%Y-%m-%d-%H:%M`"$so"

# 备份路径
path="$(pwd)/$filename"

# 执行备份
# 检查文件是否已经生成
if [ -f "$path" ]
then
	echo "备份文件已经在：$path"
else
	mysqldump -u$username -p$password $database >$path
	echo "Great, $filename has been created!"
fi
```