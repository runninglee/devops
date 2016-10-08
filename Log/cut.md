# cut
显示行中指定的部分，盛出文件中指定的字段

## Options

```
     -b list
             以字节定位

     -c list
             以字符定位

     -d delim
             使用delim替换tab做为字段分隔符

     -f list
             输出指定的字段，数字索引

     -n      
             取消多字符关联，与b一起使用

     -s      Suppress lines with no field delimiter characters.  Unless speci-
             fied, lines with no delimiters are passed through unmodified.
```


使用方式

取第二个，第三个，第四个，第19个字节

> cut nginx.log -b 2-4,10

取第三个，第四个，第五个，第七个字符

> cut php.log -c 3-5,7

输出第五个字节以前的字符

> cut me.log -b -5

输出第五个字节以后的字符

> cut me.log -b 5-

 输出第一个，第三个，第四个，第五个字符
 
> cut mongodb.log -f 1,3-5
 
输出前两个字段数据的分隔符为;

> cut redis.log -d ; -f 1,2

当遇到多字节字符（中文）时，可以使用-n选项，-n用于告诉cut不要将多字节字符拆开

> cat ch.txt | cut -nb 1,2,3 （多字符合并为一个字符，只取第一个）


## History

V1: 基础结构

## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)