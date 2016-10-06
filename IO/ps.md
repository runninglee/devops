# ps

用来显示当前进程的状态


```
PID: 运行着的命令(CMD)的进程编号
%CPU: CPU使用量（非默认）
%MEM: MEM内存使用量(非默认)
TTY: 命令所运行的位置（终端）
TIME: 运行着的该命令所占用的CPU处理时间
CMD: 该进程所运行的命令

```


## Usage

```
a : 显示所有进程
-a: 显示同一终端下的所有程序
-A: 显示所有进程
c : 显示进程的真实名称
-e: 等于“-A”
e : 显示环境变量
f : 显示程序间的关系
-H: 显示树状结构
u  : 指定用户的所有进程
-au: 显示较详细的资讯
```

> ps -ax

显示所有当前进程

> ps -u www

显示www用户的进程

> ps -ef

显示所有进程信息，连同命令行

> ps －aux

列出目前所有的正在内存当中的程序

> ps -aux | more(less)

管道和 more或less连接起来分页查看

> ps -aux > me.log

输出进程信息到到me.log文件

>  ps -o pid,ppid

输出指定的字段,更多看```man ps```

## History

v1: 基本使用方法


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)