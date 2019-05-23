# lsof

lsof查看进程状态


### 参数

```
-a：列出打开文件存在的进程；
-c：列出指定进程所打开的文件； 
-g：列出GID号进程详情； 
-d：列出占用该文件号的进程； 
+d：列出目录下被打开的文件； 
+D：递归列出目录下被打开的文件； 
-n：列出使用NFS的文件； 
-i：列出符合条件的进程; 
-p：列出指定进程号所打开的文件； 
-u：列出UID号进程； 
-h：显示帮助； 
-v：显示版本;
```

###使用

**查看端口**

lsof -i:9500




## License


[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)