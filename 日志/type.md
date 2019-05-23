# type

type命令用来显示指定命令类型，判断给出的指令是内部还是外部指令

## 类型

```
alias:    别名
keyword:  关键字
function: 函数，shell函数
builtin:  内建命令，shell内建命令
file：    文件，磁盘文件，外部命令
unfound:  没有找到
```

> type option command

```
-t: 输出文件类型
-p: 如果给出的指令为外部指令，则显示绝对路径
-a: 在环境变量PATH指定的路径中，显示给定指令的信息，包括路径信息
```

## History

V1: 基础命令


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)