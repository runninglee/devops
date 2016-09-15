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


**常用结合命令read**