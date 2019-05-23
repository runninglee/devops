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
	
### 三、安装es： ###
	apt-get update && apt-get install elasticsearch
		3.1、ES配置文件位置：
		 	配置文件包括 elasticsearch.yml：/etc/elasticsearch/elasticsearch.yml
		 	log日志位置：/var/log/elasticsearch
		 	二进制脚本，包括elasticsearch启动节点和elasticsearch-plugin安装插件：/usr/share/elasticsearch/bin	
			Elasticsearch主目录：/usr/share/elasticsearch
			环境变量包括堆大小，文件描述符：/etc/default/elasticsearch
			在节点上分配的每个索引/分片的数据文件的位置：/var/lib/elasticsearch
			插件文件的位置。每个插件将被包含在一个子目录中：/usr/share/elasticsearch/plugins
		3.2、加入自启动：
	 		1、update-rc.d elasticsearch defaults 95 10
	 		2、/bin/systemctl daemon-reload
	 		3、/bin/systemctl enable elasticsearch.service
		3.3、
			当systemd启用日志记录时，日志信息可以使用以下journalctl命令：sudo journalctl -f
			要列出elasticsearch服务的日记帐分录：sudo journalctl --unit elasticsearch
			要从给定时间开始列出elasticsearch服务的日记帐分录，请执行以下操作：sudo journalctl --unit elasticsearch --since  "2016-10-30 18:17:16"
		3.4、/etc/default/elasticsearch参数：
			JAVA_HOME：设置要使用的自定义Java路径。
			MAX_OPEN_FILES：打开文件的最大数量，默认为65536。
			MAX_LOCKED_MEMORY：最大锁定内存大小。设置为unlimited如果您使用bootstrap.memory_lockelasticsearch.yml中的 选项。
			MAX_MAP_COUNT：进程可能具有的最大内存映射区域数量。如果您使用mmapfs 索引存储类型，请确保将其设置为较高的值。欲了解更多信息，请查看 Linux内核文件 有关max_map_count。这是通过sysctl在开始elasticsearch之前设置的。默认为262144。
			ES_PATH_CONF：配置文件目录（其中必须包括elasticsearch.yml， jvm.options，和log4j2.properties文件）; 默认为 /etc/elasticsearch。
			ES_JAVA_OPTS：您可能要应用的任何其他JVM系统属性。
			RESTART_ON_UPGRADE：配置软件包升级重启，默认为false。这意味着您必须在手动安装包后重新启动elasticsearch实例。其原因是为了确保集群中的升级不会导致连续的碎片重新分配，从而导致高网络流量并缩短集群的响应时间。

### 三、安装x-pack: ###
	wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.0.0.zip
	root@es01:/usr/share/elasticsearch# pwd
	/usr/share/elasticsearch
	root@es01:/usr/share/elasticsearch# bin/elasticsearch-plugin install file:///tmp/x-pack-6.0.0.zip
	
### 四、修改es参数： ###
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
	

# 安装kibana： #

### 一、安装： ###
	apt-get install kibana

### 二、安装x-pack ###
	wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.0.0.zip
	root@es01:/usr/share/kibana# pwd
	/usr/share/kibana
	root@es01:/usr/share/kibana# bin/kibana-plugin install file:///tmp/x-pack-6.0.0.zip
	
### 二、配置： ###
	root@kibana:~# grep "^[a-z]" /etc/kibana/kibana.yml 
	server.port: 5601	------------------------------------------ 端口
	server.host: "0.0.0.0"	-------------------------------------- ip bind 绑定
	elasticsearch.url: "http://10.0.0.11:9200"	------------------ es服务地址和端口 http协议
	elasticsearch.username: "kibana"	-------------------------- 生成的kibana用户
	elasticsearch.password: "123456"	-------------------------- 生成的kibana用户密码（123456是用elastic超级管理用户登录kibana后更改的）
	
### 四、启动kibana ###
	/etc/init.d/kibana start

### 五、使用elastic用户进入kibana 更改用户密码或者创建对应角色的用户 ###
	
# x-pack高级功能需要购买官方的高级别的 xpack license,可以免费注册1年使用限制的basic license。 #

### 一、注册网址： ###
	https://register.elastic.co/xpack_register
	
### 二、导入license方法 ###
	curl -XPUT -u elastic 'http://<host>:<port>/_xpack/license?acknowledge=true' -H "Content-Type: application/json" -d @<license.json>
	
### 三、basic license 功能少 导入后就没有了安全认证和安全ssl等功能，但是可以使用monitor监控，最主要的是可以看到写入es的数据索引 ###
	...

# 注意事项 #
## 如果出现ES启动不起来的问题，有可能是内存限制的原因，修改jvm配置文件调整最大和最小内存参数   ##
