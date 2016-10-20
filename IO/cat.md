# cat

具体使用不详

###参数

```
     -b     输出非空白的行号，从1开始(输出跟n一样)

     -e     输出字符的结尾以$结尾

     -n     输出行号，从1开始
```
###用途

* 在屏幕上输出文本文件
* 拷贝文本文件
* 合并文本文件
* 创建新的文本文件

###使用案例

读取文件

```
$ cat /usr/local/log.txt
```

输出打印信息到文件中

```
$ cat /usr/local/log.txt > back_log.txt
```

连接多个文件输出（每个文件以换行的方式输出）

```
$ cat log1 log2 log3
```

合并多个文件到一个文件中

```
$ cat log1 log2 log3 > log.txt
```

写入文本到指定文件中

```
$ cat > log.txt
```

追加的方式写入文本文件中

```
$ cat  >> log.txt
```


查看文本的行号

```
$ cat  －n(b) log.txt
```

文本结尾补$

```
$ cat  －e log.txt
```

直接输出文本不带行号

```
$ cat  －s log.txt
```

## History

V1: 总结常用的cat方法

TODO: 增加cat在bash中的案列

## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)