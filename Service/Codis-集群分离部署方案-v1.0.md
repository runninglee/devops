# Codis简介：
## Codis 是一个分布式 Redis 解决方案, 对于上层的应用来说, 连接到 Codis Proxy 和连接原生的 Redis Server 没有显著区别 (不支持的命令列表), 上层应用可以像使用单机的 Redis 一样使用, Codis 底层会处理请求的转发, 不停机的数据迁移等工作, 所有后边的一切事情, 对于前面的客户端来说是透明的, 可以简单的认为后边连接的是一个内存无限大的 Redis 服务。

## Codis redis集群方案
### 根据公司线上需求及资源限制原因，规划codis的分布式部署将各组件分离部署到两台主机上，满足高可用和负载需求。
	


Codis分布式集群架构图：

![](https://raw.githubusercontent.com/CodisLabs/codis/release3.2/doc/pictures/architecture.png)

## 部署规划

#### codis01: 10.0.0.21

		部署：
			codis-proxy : 无状态代理，负责客户端连接代理redis服务，客户端连接proxy如同连接单节点redis一样
			codis-server: codis管理redis服务的组件
			redis-sentine: redis哨兵服务，用于codis调用redis哨兵管理redis主从切换
			zookeeper   : 为集群状态提供外部存储

#### codis02: 10.0.0.22
		部署：
			codis-proxy
			codis-server
			codis-dashboard:集群管理工具，codis-proxy、codis-server 的添加、删除，以及据迁移等操作。
			在集群状态发生改变时，codis-dashboard 维护集群下所有 codis-proxy 的状态的一致性
			codis-fe: 集群管理界面
			多个集群实例共享可以共享同一个前端展示页面；
			通过配置文件管理后端 codis-dashboard 列表，配置文件可自动更新
			redis-sentine:

## 部署步骤（测试环境搭建）：

#### 环境准备：


		一、为两台虚拟机配置go环境和java环境，两台都做：

			1、获取安装包：
				https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
				http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
			2、安装环境：
			2.1 安装java环境 直接源安装：
				# apt-get install oracle-java8-installer
				# java -version
				java version "1.8.0_144"
				Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
				Java HotSpot(TM) 64-Bit Server VM (build 25.144-b01, mixed mode)
			3、安装部署go环境：
				3.1 安装go：
				# tar xf go1.8.3.linux-amd64.tar.gz -C /usr/local/
			3.2 设置go环境变量：
				# vim /root/.bashrc
				export GOROOT=/usr/local/go # 安装路径 
				export GOPATH=/usr/local/codis # 工作路径 
				export PATH=$PATH:$GOPATH/bin:$GOROOT/bin # 命令搜索路径

		二、编译安装codis，两台都做：

			1、 获取 codis代码：
				# cd /usr/local/src/
				# wget https://codeload.github.com/CodisLabs/codis/zip/release3.2
			2、 解压 codis代码压缩包：
				# mkdir -p /usr/local/codis/src/github.com/CodisLabs
				# unzip codis-release3.2.zip
				# mv /usr/local/src/codis-release3.2 /usr/local/codis/src/github.com/CodisLabs/
				# cd /usr/local/codis/src/github.com/CodisLabs/
				# ln -s codis-release3.2 codis
			3、 编译
				# cd /usr/local/codis/src/github.com/CodisLabs/codis
				# make 
			
			4、 查看脚本和命令：
			 	ll admin/
			
				用量 16
				rwxr-xr-x 1 root staff 2282 8月  10 20:27 codis-dashboard-admin.sh
				rwxr-xr-x 1 root staff 1796 8月  10 20:27 codis-fe-admin.sh
				rwxr-xr-x 1 root staff 2102 8月  10 20:27 codis-proxy-admin.sh
				rwxr-xr-x 1 root staff 1722 8月  10 20:27 codis-server-admin.sh
			
			 	ll bin/
			
				用量 93272
				rwxr-sr-x 4 root staff     4096 8月  24 13:23 assets
				rwxr-xr-x 1 root staff 15213264 8月  24 13:23 codis-admin
				rwxr-xr-x 1 root staff 16795632 8月  24 13:23 codis-dashboard
				rwxr-xr-x 1 root staff 14943632 8月  24 13:23 codis-fe
				rwxr-xr-x 1 root staff 13333488 8月  24 13:23 codis-ha
				rwxr-xr-x 1 root staff 18820552 8月  24 13:23 codis-proxy
				rwxr-xr-x 1 root staff  5501208 8月  24 13:23 codis-server
				rw------- 1 root staff    14525 8月  24 16:32 nohup.out
				rwxr-xr-x 1 root staff  2600864 8月  24 13:23 redis-benchmark
				rwxr-xr-x 1 root staff  2754416 8月  24 13:23 redis-cli
				rwxr-xr-x 1 root staff  5501208 8月  24 14:58 redis-sentinel
				rw-r--r-- 1 root staff       96 8月  24 13:23 version
				oot@codis1:/usr/local/codis/src/github.com/CodisLabs/codis# 

			5、拷贝codis程序：
				# mkdir -p /usr/local/codis/{bin,config,log}
				# cp -fr /usr/local/codis/src/github.com/CodisLabs/codis/bin/* /usr/local/codis/bin/
				# cp -fr /usr/local/codis/src/github.com/CodisLabs/codis/config/* /usr/local/codis/config/

 
#### 部署zookeeper服务：[10.0.0.21]


			1.1 部署zookeeper服务：部署为多实例: 到正式环境 可以将三个zk节点分别部署到三个服务器上
				# tar xf zookeeper-3.4.9.tar.gz -C /usr/local/
				# mkdir /opt/zk{1,2,3}
				# cp /usr/local/zookeeper/conf/zoo_sample.cfg /opt/zk1/zk1.cfg
				# cp /usr/local/zookeeper/conf/zoo_sample.cfg /opt/zk2/zk2.cfg
				# cp /usr/local/zookeeper/conf/zoo_sample.cfg /opt/zk3/zk3.cfg
				# cd /opt/
				# echo 1 > zk1/myid
				# echo 2 > zk2/myid
				# echo 3 > zk3/myid

			1.2 修改zk配置文件内容如下：
				# grep "^[a-Z]" zk1/zk1.cfg 
				tickTime=2000
				initLimit=10
				syncLimit=5
				dataDir=/opt/zk1
				clientPort=2181
				server.1=10.0.0.21:2887:3887
				server.2=10.0.0.21:2888:3888
				server.3=10.0.0.21:2889:3889
				
				 # grep "^[a-Z]" zk2/zk2.cfg 
				tickTime=2000
				initLimit=10
				syncLimit=5
				dataDir=/opt/zk2
				clientPort=2182
				server.1=10.0.0.21:2887:3887
				server.2=10.0.0.21:2888:3888
				server.3=10.0.0.21:2889:3889
				
				# grep "^[a-Z]" zk3/zk3.cfg 
				tickTime=2000
				initLimit=10
				syncLimit=5
				dataDir=/opt/zk3
				clientPort=2183
				server.1=10.0.0.21:2887:3887
				server.2=10.0.0.21:2888:3888
				server.3=10.0.0.21:2889:3889

			1.3 启动zk服务：
				# /usr/local/zookeeper/bin/zkServer.sh start /opt/zk1/zk1.cfg
				# /usr/local/zookeeper/bin/zkServer.sh start /opt/zk2/zk2.cfg
				# /usr/local/zookeeper/bin/zkServer.sh start /opt/zk3/zk3.cfg
				查看服务状态
				# /usr/local/zookeeper/bin/zkServer.sh status /opt/zk1/zk1.cfg 
				ZooKeeper JMX enabled by default
				Using config: /opt/zk1/zk1.cfg
				Mode: follower
				
				# /usr/local/zookeeper/bin/zkServer.sh status /opt/zk2/zk2.cfg 
				ZooKeeper JMX enabled by default
				Using config: /opt/zk2/zk2.cfg
				Mode: leader
				
				# /usr/local/zookeeper/bin/zkServer.sh status /opt/zk3/zk3.cfg
				ZooKeeper JMX enabled by default
				Using config: /opt/zk3/zk3.cfg
				Mode: follower

#### 部署codis-server: [本测试 双实例部署{10.0.0.21，10.0.0.22都部署一套双实例，配置文件修改和命名方式一样}]
				
				1.1 创建codis-server多实例配置文件
					# cd /usr/local/codis/config
					# cp redis.cnf redis_6379.conf 
					# cp redis.cnf redis_6381.conf
				1.2 修改多实例配置文件参数： 
					# vim redis_6379.conf 
					# 部分关键参数
					
					bind 0.0.0.0 -------------- IP
					
					port 6379    -------------- 端口
					
					
					pidfile "/tmp/redis_6379.pid" ------------- pid
					
					logfile "/tmp/redis_6379.log" -------------- 日志
					
					databases 16                  -------------- db数量可修改更多
					
					save 900 1                    -------------- 持久化rdb
					save 300 10
					save 60 10000
					
					dbfilename "dump_6379.rdb"    -------------- 持久化rdb文件
					
					dir "/usr/local/codis-release3.2"  -------------codis程序主目录
					
					masterauth "123456"           -------------- 主从同步密码
					
					slave-read-only yes           -------------- 作为从库后只读
					
					requirepass "123456"          -------------- 客户端访问redis服务密码
					
					maxmemory 1g                  -------------- 最大内存阈值
					
					appendonly yes                -------------- aof持久化
					appendfilename "appendonly_6379.aof" ------- aof持久化文件
					appendfsync everysec
					
					# vim redis_6381.conf 
					# 部分关键参数
					
					bind 0.0.0.0 -------------- IP
					
					port 6381    -------------- 端口
					
					
					pidfile "/tmp/redis_6381.pid" ------------- pid
					
					logfile "/tmp/redis_6381.log" -------------- 日志
					
					databases 16                  -------------- db数量可修改更多
					
					save 900 1                    -------------- 持久化rdb
					save 300 10
					save 60 10000
					
					dbfilename "dump_6381.rdb"    -------------- 持久化rdb文件
					
					dir "/usr/local/codis-release3.2"  -------------codis程序主目录
					
					masterauth "123456"           -------------- 主从同步密码
					
					slave-read-only yes           -------------- 作为从库后只读
					
					requirepass "123456"          -------------- 客户端访问redis服务密码
					
					maxmemory 1g                  -------------- 最大内存阈值
					
					appendonly yes                -------------- aof持久化
					appendfilename "appendonly_6379.aof" ------- aof持久化文件
					appendfsync everysec

				1.3 启动codis-server服务

					一、10.0.0.21:
						# cd /usr/local/codis
						# ./bin/codis-server config/redis_6379.conf 
						# ./bin/codis-server config/redis_6381.conf 
					二、10.0.0.22：
						# cd /usr/local/codis
						# ./bin/codis-server config/redis_6379.conf 
						# ./bin/codis-server config/redis_6381.conf 
					三、查看服务启动进程及端口：
						# netstat -lntp|grep codis-server
						tcp        0      0 0.0.0.0:6379            0.0.0.0:*               LISTEN      45557/codis-server 
						tcp        0      0 0.0.0.0:6381            0.0.0.0:*               LISTEN      35399/codis-server 

#### 部署codis-dashboard服务[此服务搭建在 10.0.0.12上]：
				
				1.1、生成codis-dashboard的配置文件：
					# cd /usr/local/codis/bin/
					# ./codis-dashboard --default-config | tee /usr/local/codis/config/dashboard.conf 
					
				1.2  修改配置文件：
					# vim ../conf/dashboard.conf
					coordinator_name = "zookeeper" # 外部存储类型 
					coordinator_addr = "10.0.0.21:2181,10.0.0.21:2182,10.0.0.21:2183" # 外部存储IP列表
				
					product_name = "codis-fx" # 项目名称 
					product_auth = “123456” # 集群密码（注意:需要与redis配置中的requirepass保持一致）
					
					admin_addr = "0.0.0.0:18080" # RESTful API 端口
				
				1.3 为了防止出现dashboard监控页面中OPS始终为0的现象，需要将各proxy的IP和主机名写到hosts文件中 [host文件互相解析主机名]
				
				1.4 启动codis-dashboard
					# cd /usr/local/codis/bin/
					# nohup ./codis-dashboard --ncpu=2 --config=/usr/local/codis/config/dashboard.conf --log=/usr/local/codis/log/dashboard.log --log-level=WARN &
					如果想关闭dashboard服务，可执行：
					#./codis-admin --dashboard=10.0.0.22:18080 –auth=123456 --shutdown
				
				1.5 查看服务进程和端口：
					netstat -lntp|grep codis-dashboa
					tcp6       0      0 :::18080                :::*                    LISTEN      11266/codis-dashboa

#### 部署codis-proxy服务[两台服务器上都搭建此服务(配置文件相同)，可配合keepalived做高可用代理，也可此代理前端用haproxy做负载均衡]

			1.1、生成codis-proxy的配置文件：
				# cd /usr/local/codis/bin/
			    # ./codis-proxy --default-config | tee /usr/local/codis/config/proxy.conf 
			
			1.2  修改配置文件：
				# vim ../config/proxy.conf 
				product_name = "codis-fx" # 设置项目名 
				product_auth = "123456" # 设置登录dashboard的密码（注意：与redis中requirepass一致）
				
				session_auth = "56789" # Redis客户端的登录密码（注意：与redis中requirepass不一致） 
				# Set bind address for admin(rpc), tcp only. 
				admin_addr = "0.0.0.0:11080" 
				# Set bind address for proxy, proto_type can be “tcp”,”tcp4”, “tcp6”, “unix” 
				or “unixpacket”. 
				proto_type = “tcp4” 
				proxy_addr = "0.0.0.0:19000" #绑定端口（Redis客户端连接此端口） 
				# 外部存储 
				jodis_name = "zookeeper" # 外部存储类型 
				jodis_addr = "10.0.0.21:2181,10.0.0.21:2182,10.0.0.21:2183" # 外部存储列表 
				jodis_timeout = “20s
			
			1.4 启动codis-proxy
				# cd usr/local/codis/bin/
				# nohup ./codis-proxy --ncpu=2 --config=/usr/local/codis/config/proxy.conf --log=/usr/localcodis/log/proxy.log --log-level=WARN &
			
			1.5 查看服务进程和端口：
				# netstat -lntp|grep codis-proxy
				tcp        0      0 0.0.0.0:19000           0.0.0.0:*               LISTEN      12931/codis-proxy
				tcp6       0      0 :::11080                :::*                    LISTEN      12931/codis-proxy

#### 部署Redis-sentinel服务：
               Redis官方推荐的高可用性(HA)解决方案。它可以实现对Redis的监控、通知、自动故障转移：
               注意： [两台服务器都搭建一个，作为高可用，
                     而且对于判断主从切换，需要两个sentinel服务都检测故障才可切换主从，
                     所以为了高可用，生产环境许搭建三个为一集群
                     本测试环境搭建两个]

			1、拷贝程序：
				 # cd /usr/local/codis/
				 # cp -fr src/github.com/CodisLabs/codis/extern/redis-3.2.8/src/redis-sentinel /usr/local/codis/bin/
			2、拷贝配置：
				# cd usr/local/codis/
				# cp -fr src/github.com/CodisLabs/codis/extern/redis-3.2.8/sentinel.conf /usr/local/codis/config/
			3、修改配置：
				# mkdir /usr/local/codis/data/
				# cd /usr/local/codis/config/
				# vim sentinel.conf
				bind 0.0.0.0 
				protected-mode no 
				port 26379 
				dir "/usr/local/codis/data/"
				备注：其他结点的配置与此一致。
			
			4、启动Redis-sentinel：
				# cd /usr/local/codis/bin
				# nohup ./redis-sentinel /usr/local/codis/config/sentinel.conf &
			
			5、查看服务进程和端口号
				# netstat -lntp|grep redis-sentine
				tcp        0      0 0.0.0.0:26379           0.0.0.0:*               LISTEN      11866/redis-sentine

#### 部署codis-fe服务 集群管理界面

			注意：[需要和codis-dashboard搭建在同一台服务器上，搭建在10.0.0.22]
			
			1、生成配置文件：
				# cd /usr/local/codis/bin
				# ./codis-amdin - -dashboard-list --zookeeper=10.0.0.21:2181 | tee /usr/local/codis/config/codis.json
				[ 
					{ 
					“name”:”codis-fx”, 
					“dashboard”:10.0.0.22:18087” 
					} 
				]
			
			2、启动codis-fe：
				# nohup ./codis-fe --ncpu=2 --log=/usr/local/codis/log/fe.log --log-level=WARN --dashboard-list=/usr/local/codis/config/codis.json --listen=0.0.0.0:18090 &
			
			3、查看服务进程和端口
				# netstat -lntp|grep codis-fe
				tcp6       0      0 :::18090                :::*                    LISTEN      12771/codis-fe
			
			
#### 至此codis集群搭建完毕：
			打开浏览器，输入10.0.0.22:18090便可看到codis集群的监控界面：
			链接codis操作redis： redis-cli -h 10.0.0.21 -p 19000 -a 56789
