# 安装6.x版本 elasticsearch #

## ES和kibana都需要java环境： ##
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    apt-get update
    apt-get install oracle-java8-installer

### 一、下载并安装公共签名密钥： ###
	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	
### 二、安装仓库： ###
	apt-get install apt-transport-https
	echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main"| sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
	
### 三、安装ES： ###
	apt-get update && apt-get install elasticsearch

### 三、安装x-pack: ###
	wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.0.0.zip
	root@es01:/usr/share/elasticsearch# pwd
	/usr/share/elasticsearch
	root@es01:/usr/share/elasticsearch# bin/elasticsearch-plugin install file:///tmp/x-pack-6.0.0.zip
	
### 四、修改ES参数： ###
	root@es02:~# grep "^[a-z]" /etc/elasticsearch/elasticsearch.yml 
	cluster.name: fx-erp	-------------------------------------- 集群名称
	node.name: es02		---------------------------------------------- 节点名称，与主机名一样就行
	path.data: /var/lib/elasticsearch	------------------------------ 默认数据存储位置 可更改 权限授权elasticsearch用户
	path.logs: /var/log/elasticsearch	------------------------------ 默认日志位置 可更改
	network.host: 0.0.0.0	------------------------------------------ ip地址bind 绑定 
	http.port: 9200		---------------------------------------------- 端口
	discovery.zen.ping.unicast.hosts: ["10.0.0.11", "10.0.0.111"]	-------------- 发现节点的列表组，列表内的ip为本集群的节点ip
	
### 五、启动ES： ###
	root@es02:~# /etc/init.d/elasticsearch start
	
### 六、初始化x-pack认证用户： ###
	root@es02:~# cd /usr/share/elasticsearch/
	root@es02:/usr/share/elasticsearch# bin/x-pack/setup-passwords auto	---------- 5.x 版本默认会有elastic superuser用户 但6.x 使用此命令初始化用户

### 七、记住elastic，kibana，logstash 用户和密码 ###
    ...

# 安装kibana： #


### 一、安装： ###
	apt-get install kibana

### 二、安装x-pack ###
	wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.0.0.zip
	root@es01:/usr/share/kibana# pwd
	/usr/share/kibana
	root@es01:/usr/share/kibana# bin/kibana-plugin install file:///tmp/x-pack-6.0.0.zip
	
### 三、配置： ###
	root@kibana:~# grep "^[a-z]" /etc/kibana/kibana.yml 
	server.port: 5601	------------------------------------------ 端口
	server.host: "0.0.0.0"	-------------------------------------- ip bind 绑定
	elasticsearch.url: "http://10.0.0.11:9200"	------------------ es服务地址和端口 http协议
	elasticsearch.username: "kibana"	-------------------------- 生成的kibana用户
	elasticsearch.password: "123456"	-------------------------- 生成的kibana用户密码（123456是用elastic超级管理用户登录kibana后更改的）
	
### 四、启动kibana ###
	/etc/init.d/kibana start

### 五、使用elastic用户进入kibana 更改用户密码或者创建对应角色的用户 ###
    ...
	
# x-pack高级功能需要购买官方的高级别的 xpack license,可以免费注册1年使用限制的basic license。 #

### 一、注册网址： ###
	https://register.elastic.co/xpack_register
	
### 二、导入license方法 ###
	curl -XPUT -u elastic 'http://<host>:<port>/_xpack/license?acknowledge=true' -H "Content-Type: application/json" -d @<license.json>
	
### 三、basic license 功能少 导入后就没有了安全认证和安全ssl等功能，但是可以使用monitor监控，最主要的是可以看到写入es的数据索引 ###
	...

# 注意事项 #
## 如果出现ES启动不起来的问题，有可能是内存限制的原因，修改jvm配置文件调整最大和最小内存参数   ##
