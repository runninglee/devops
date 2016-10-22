# MySQL优化策略

## 不良症状

* MySQL进程一直负载很高，持续不下

## 检查方案

修改wait_timeout值，释放MySQL进程,解决MySQL进程CPU过高问题；

```
# 先查看一下MySQL的wait_timeout
$ mysql> show global variables like '%timeout%';
------------------------------------------------
# 修改my.cnf,下面两个值同时修改方可生效
wait_timeout=120
interactive_timeout=120
# 重启MySQL
service mysqld restart
```

查找数据库表索引问题造成的MySQL进程负载过高

```
# 查看MySQL进程列表
$ mysql> show full processlist;
------------------------------------------------
# 根据列出来的问题，优化程序索引，优化查询方式
```

## 优化方案


[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)