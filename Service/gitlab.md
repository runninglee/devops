# gitlab

Debian7下安装gitlab9.2版本

### 下载地址

[gitlab地址](https://about.gitlab.com/downloads/#debian7)

### 安装配置依赖包

> sudo apt-get install curl openssh-server ca-certificates postfix

### 安装gitlab

> curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

> sudo apt-get install gitlab-ce

### 安装Postgresql

[PostgreSQL Apt Repository](https://www.postgresql.org/download/linux/debian/)

> sudo apt-get install postgresql9.4

修改postgres用户密码

> sudo passwd postgres;

修改postgres密码

1. 切换用户

> sudo su - postgres

2. 登陆

> psql

3. 修改密码

> ALTER USER postgres WITH PASSWORD 'postgres';

> \q;

### 配置gitlab

1. 修改配置文件

> sudo vi /etc/gitlab/gitlab.rb

2. 复制nginx文件

>  cp /var/opt/gitlab/nginx/conf/gitlan-http.conf /usr/local/nginx/conf/vhost/.

3. 修改权限

>  sudo usermod -aG gitlab-www www

重启Nginx

> service nginx restart


### 启动gitlab

> sudo gitlab-ctl reconfigure

> sudo gitlab-ctl start

### 问题

1. 数据库连接不上的问题

2. Nginx 502












[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)