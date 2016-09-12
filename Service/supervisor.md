### Supervisor Service
---

### Install

`sudo apt-get update`
`sudo apt-get install supervisor`

###  Configuration

**create configure file**

> cd /etc/supervisor/conf.d && cat yourproject.conf

```
[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /home/forge/app.com/artisan queue:work sqs --sleep=3 --tries=3 --daemon
autostart=true
autorestart=true
user=username
numprocs=8
redirect_stderr=true
stdout_logfile=/home/forge/app.com/worker.log

```

**make it work**

> /etc/init.d/supervisord {start|stop|restart|force-reload|status|force-stop}   

`server side (if you can't set the dot conf file, you won't start the supervisord)`

> sudo supervisorctl reread

`client side reload configure file`      

> sudo supervisorctl update  

`client side update configure file`


### Test


 TODO：Let't code in laravel


### How to renew？

> php artisan queue:restart

