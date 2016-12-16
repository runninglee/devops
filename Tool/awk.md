# awk

awk是一种编程语言，用于在linux/unix下对文本和数据进行处理；

## 语法

> awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]

> -F 是分割符

> -v  条件表达式

> prog 命令集合

> file 分析处理的目标文件

## 使用

> awk -f ':' '{print($1,$2)}' > me.log

##License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)