# Supervisor Service

debian下安装supervisor,使用于laravel队列任务

## 安装

`sudo apt-get update`

`sudo apt-get install supervisor`


## 创建配置文件

`cd /etc/supervisor/conf.d && cat yourproject.conf`

```nginx
[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /home/forge/app.com/artisan queue:work sqs --sleep=3 --tries=3 --daemon
autostart=true
autorestart=true
user=username
numprocs=16 (CPUX8)
redirect_stderr=true
stdout_logfile=/home/forge/app.com/worker.log
```

## 服务管理

`/etc/init.d/supervisor {start|stop|restart|force-reload|status|force-stop} `

> 必须配置yourproject.conf,否则服务端supervisord启动不了


sudo supervisorctl reread

## 重新加载客户端配置     

sudo supervisorctl update


## 启动客户端配置

sudo supervisorctl start all


## 区别

supervisord是服务进程，用户管理supervisor进程，supervisorctl是客户端进程，用于管理系统中的子任务进程，一般情况下，任务配置修更新客户端进程，服务进程编程更新supervisor配置

## 测试

项目测试运用于laravel项目


## 重启服务

`php artisan queue:restart`

队列服务在项目代码部署之后，需要重新队列任务，否则新的队列任务将不会生效，下面是laravel的更新方式

## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)
