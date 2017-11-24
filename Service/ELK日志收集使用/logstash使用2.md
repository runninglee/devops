# 一、logstash获取rsyslog #

## 1、修改rsyslog配置文件 ##


	[root@linux-node02 ~]# tail -5 /etc/rsyslog.conf 

    *.* @@10.0.0.12:514 ---------------------------------------------------取消注释 修改ip地址

	[root@linux-node02 ~]# 
	[root@linux-node02 ~]# systemctl restart rsyslog

## 2、创建logstash 配置文件 ##

	input{
		syslog{
		   type => "system-syslog"
		   port => "514"
		}
	}

	output{
		elasticsearch{
			   hosts => ["10.0.0.12:9200"]
			   index => "systemc-syslog-%{+YYYY.MM}"
		}

		stdout{
			codec => rubydebug

		}

	}

# 二、logstash获取tcp udp 日志 #

	input{

	   tcp{
		  type => "tcp-log}"
		  port => "6666"
		  mode => "server"

	   }

	}


	output{
	   stdout{
		   codec => rubydebug


	   }



	}

## 1、使用nc命令传送消息 ##

	[root@linux-node01 ~]# nc 10.0.0.12 6666 < /etc/passwd
	[root@linux-node01 rsyslog.d]# echo "hehe"|nc 10.0.0.12 6666
	[root@linux-node01 rsyslog.d]# echo "hehe" > /dev/tcp/10.0.0.12/6666 ------------伪设备传送方式
 
 
 
# 三、filter grok 学习收集apache日志未json格式 #

	[root@linux-node02 conf]# cd /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-patterns-core-2.0.5/patterns/

	[root@linux-node02 patterns]# ls
	aws     bro   firewalls      haproxy  junos         mcollective           mongodb  postgresql  redis
	bacula  exim  grok-patterns  java     linux-syslog  mcollective-patterns  nagios   rails       ruby

	[root@linux-node02 patterns]# cat grok-patterns -------------apache grok 日志定义

	www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html

	配置logstash filter grok 配置文件：

	input{
		file{
		   path => "/var/log/httpd/access_log"
		   start_position => "beginning"
		}
	}

	filter{
		grok {
		   match => { "message" => "%{COMMONAPACHELOG}" } ------- grok-patterns 此文件中定义了这个格式
		}
	}

	output{
		elasticsearch{
			   hosts => ["10.0.0.12:9200"]
			   index => "apache-log-%{+YYYY.MM.dd}"
		}
		stdout{
		  codec => rubydebug
		}
	}

# 四、logstash将日志写入redis #

	流程过程：
	
	server------》logstash -----》redis-----》logstash-------》elasticsearch
	
	input{
		file{
		   path => "/var/log/httpd/access_log"
		   start_position => "beginning"
		}
	}


	output{
		redis{
			   host => "10.0.0.12"
			   port => "6379"
			   db => "6"
			   data_type => "list"
			   key => "apache-accesslog"
		}
	}

## 五、使用另一个logstash收取redis存的日志 ##

	input{
	    redis{
	          host => "10.0.0.12"
	          port => "6379"
	          db => "6"
	          data_type => "list"
	          key => "apache-accesslog"
	    }
	
		
		
	output{
		    stdout{
		        codec => rubydebug
		    }
		}

	
# 生产需求分析： #

		访问日志：apache访问日志、nginx访问日志、tomcat file - filter
		错误日志：error log、java日志 直接收 java异常需要处理
		系统日志：/var/log/* rsyslog  
		运行日志：程序写的日志     file json
		网络日志：防火墙、交换机、路由器的日志
		1、标准化： 日志放哪里/data/logs，格式是什么(json)、命名规则 access_log error_log  runtime_log
			日志回滚  按天 按小时  access error crontab进行切分 runtime_log 
			所有的原始文本 rsync到NAS,删除最近三天前的
		2、工具化：	 如何使用logstash进行收集方案

# 注意： 后台启动logstash 需要删除前面测试时候前台运行logstash生成的sincdb文件 #
		位置: 用户家目录
		      /var/lib/logstash
				


