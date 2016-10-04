# tail

显示文本后面信息

## 使用方法

> tail [-F | -f | -r] [-q] [-b number | -c number | -n number] [file ...]

```
-F: 等于－rf
-f: 自动刷新变化的页面
-r: 文件启动tai命令的是否，文本被锁定
-q: 多个文件输出的使用，只输出文件名
-b: 输出文本number个字节的字符
-c: 输出文本最后number字符
-n: 从倒数n行到文本最后
```


## 使用案例

输出文本最后30行

> tail －30 text.log

动态输出文本最后30行，用于监控日变化

> tail -f -30 nginx.log

## History

V1: 描述tail基础命令


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)