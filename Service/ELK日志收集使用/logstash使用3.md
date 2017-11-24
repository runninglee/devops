# logstash 项目实践 #
##     流程 ：server------》logstash -----》redis-----》logstash-------》elasticsearch ##

## 一、linux-node02: 收集系统日志、apache日志、elasticsearch日志 到redis缓存 ##

    开启rsyslog 日志推送端口
	cat /etc/rsyslog.conf

	*.* @@10.0.0.12:514


	
	[root@linux-node02 conf.d]# cat shipper.conf 

	input{
		syslog{
		   type => "system-syslog" -------------logstash 收集 因为要使用logstash启动rsyslog 所以要用root权限（修改logstash启动脚本）
		   port => "514"
		}
		file{
		   path => "/var/log/httpd/access_log"  -------------- 文件收集 apache日志
		   type => "apache-accesslog"
		   start_position => "beginning"        --------------- 从文件开头内容收集
		}
		file{
			path => ["/var/log/elasticsearch/myes.log"] ---------- 文件搜集elastcsearch日志
			type => "es-log"
			start_position => "beginning"       
			codec => multiline {               ----------------- 收集内容 codec格式化 多行格式
					pattern => "^\["           ------------------ 匹配正则
					negate => true
					what => "previous"                 
			}
		}
	}

	filter{
		if [type] == "apache-accesslog" {       ----------------- 根据类型过滤日志
		   grok {
			   match => { "message" => "%{COMMONAPACHELOG}" }   --------- 使用grok /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-patterns-core-2.0.5/patterns/ 中内置定义的日志格式变量
		   }
		}
	}

	output{
	   if [type] == "es-log" {        ---------------- 根据if判断格式 将日志分别写入redis 中
		   redis{
				  host => "10.0.0.12"
				  port => "6379"
				  db => "6"
				  data_type => "list"
				  key => "es-log"
		   }
	   }
	   if [type] == "apache-accesslog" {
		   redis{
				  host => "10.0.0.12"
				  port => "6379"
				  db => "6"
				  data_type => "list"
				  key => "apache-accesslog"
		   }      
	   }
	   if [type] == "system-syslog" {
		   redis{
				  host => "10.0.0.12"
				  port => "6379"
				  db => "6"
				  data_type => "list"
				  key => "system-syslog"
		   }
	   }
	   stdout {
			codec => rubydebug
	   }
	}
	
	
## 二、linux-node01: 从redis中读取日志并写入到elasticsearch中 ##

	[root@linux-node01 conf.d]# cat shipper.conf 
	input{

		redis{
			  type => "system-syslog" ------------------从redis中读取日志 并加上type类型
			  host => "10.0.0.12"
			  port => "6379"
			  db => "6"
			  data_type => "list"
			  key => "system-syslog"
		}
		redis{
			  type => "apache-accesslog"
			  host => "10.0.0.12"
			  port => "6379"
			  db => "6"
			  data_type => "list"
			  key => "apache-accesslog"
		}
		redis{
			  type => "es-log"
			  host => "10.0.0.12"
			  port => "6379"
			  db => "6"
			  data_type => "list"
			  key => "es-log"
		}
	}

	output{
		  if [type] == "system-syslog" { ---------------------根据类型判断输出到elasticsearch中建立对应的索引
			 elasticsearch{
					 hosts => ["10.0.0.12:9200"]
					 index => "system-log-%{+YYYY.MM}"
			}
		  }
		  if [type] == "apache-accesslog" {
			 elasticsearch{
					 hosts => ["10.0.0.12:9200"]
					 index => "apache-accesslog-%{+YYYY.MM.dd}"
			 }
		  }
		  if [type] == "es-log" {
			 elasticsearch{
					 hosts => ["10.0.0.12:9200"]
					 index => "es-log-%{+YYYY.MM}"
			 }

		  }
	}

