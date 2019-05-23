# MAC下Nginx,MySQL,PHP环境开发

brew快速安装nginx,mysql,php,redis,composer,git等常用的服务及管理命令

## 安装方式

确定安装Xcode后，安装命令行工具

> xcode-select --install

安装brew

> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

安装nginx

> brew install nginx

如果使用80端口，在root下执行

> brew services [start | stop | restart] nginx

如果使用默认的8080端口，则无需切换,直接执行上面命令即可开启自启动nginx服务

nginx的配置文件中执行的用户，用户组，改成当前用户及用户组即可

访问地址测试 http://127.0.0.1

安装php70

> brew install homebrew/php/php70 homebrew/php/php70-imagick homebrew/php/php70-redis homebrew/php/php70-swoole

更多扩展```brew search php70```即可获取，随心所欲的安装，端口9000

修改php-fpm.conf中[www]中的user和group跟Nginx下的user和group一致即可

> brew services [start | stop | restart] php70

完成系统开启自启动

安装mysql5.7

> brew install mysql

默认用户密码为空,端口3306

> brew services [start | stop | restart] mysql

安装redis

>brew install redis

默认值端口6379

安装git && composer && nodejs

>brew install git

>brew install composer

查看服务启动情况

>brew services list


## 版本

V1:快速配置安装MNMP环境及常用的服务


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)