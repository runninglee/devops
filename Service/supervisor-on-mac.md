# supervisor

Mac下安装supervisor进程管理工具，方便系统监控控制服务进程


### 安装

```
brew update

brew install supervisor

```

### 配置

```

sudo supervisord -c /etc/supervisord.conf

sudo supervisorctl -c /etc/supervisord.conf

```

### 管理

```

sudo brew services {start | stop | restart} supervisord


```

### 更新配置

```
sudo brew services stop supervisord

supervisord> stop all

```


### 启动

```
sudo brew services start supervisord

sudo supervisorctl

supervisord>start (your queue worker)

```

### 帮助

```
supervisord> help

```

**命令列表**

`add` `exit` `open` `reload` `restart`  `start` `tail` `avail`

`version` `update` `reread` `clear` `status` `mailtail` `stop`


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)