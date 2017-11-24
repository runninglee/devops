#logstash使用 #

## 1、测试logstash ##
	
	[root@linux-node01 bin]# ./logstash -e 'input{ stdin{} } output{ stdout { codec => rubydebug }}'
	Settings: Default pipeline workers: 2
	Pipeline main started
	hello world!
	{
		   "message" => "hello world!",
		  "@version" => "1",
		"@timestamp" => "2017-06-21T01:02:38.554Z",
			  "host" => "linux-node01"
	}

	测试logstash命令写入es

	[root@linux-node01 bin]# ./logstash -e 'input { stdin{} } output { stdout { codec => rubydebug  } elasticsearch { hosts => ["10.0.0.11:9200"] index => "logstash-%{+YYYY.MM.dd}" } }'
	Settings: Default pipeline workers: 2
	Pipeline main started
	good
	{
		   "message" => "good",
		  "@version" => "1",
		"@timestamp" => "2017-06-21T01:15:04.853Z",
			  "host" => "linux-node01"
	}
	
## 2、可收集类型： ##
	
	rsyslog                es
	
	file                   es
	
	tcp                    es
	
## 3、logstash配置文件 ##
	
### 3.1 列子： ###
		[root@linux-node01 conf.d]# pwd
		/etc/logstash/conf.d

		[root@linux-node01 conf.d]# cat demo.conf
		input{
			stdin{}
		}


		filter{

		}

		output{

		   elaseticsearch{
				 hosts => ["10.0.0.11:9200"]
				 index => "logstash-%{+YYYY.MM.dd}"
		   }
		   stdout{
				 codec => rubydebug
		   }
		}
		
### 3.2 文件收集 ###


		input{
			file{
				path => ["/var/log/messages","/var/log/secure"]
				type => "system-log"
				start_position => "beginning"
			}
		}


		filter{

		}

		output{

		   elasticsearch {
				 hosts => ["10.0.0.11:9200"]
				 index => "system-log-%{+YYYY.MM}"
		   }
		   stdout{
				 codec => rubydebug
		   }
		}
	
	
### 3.3 logstash if判断的使用 ###

		input{
			file{
				path => ["/var/log/messages","/var/log/secure"]
				type => "system-log"
				start_position => "beginning"
			}
			file{
				path => ["/var/log/elasticsearch/myes.log"]
				type => "es-log"
				start_position => "beginning"

			}
		}


		filter{

		}

		output{
		   if [type] == "system-log" {

			   elasticsearch {
				   hosts => ["10.0.0.11:9200"]
				   index => "system-log-%{+YYYY.MM}"
			   }
		   }
		   if [type] == "es-log" {
			   elasticsearch {
					 hosts => ["10.0.0.11:9200"]
					 index => "es-log-%{+YYYY.MM}"
			   }
		   }
		   stdout{
				 codec => rubydebug
		   }
		}

### 3.4 logstash 日志格式化方式 ###
	
		input{
			file{
				path => ["/var/log/messages","/var/log/secure"]
				type => "system-log"
				start_position => "beginning"
			}
			file{
				path => ["/var/log/elasticsearch/myes.log"]
				type => "es-log"
				start_position => "beginning"
				codec => multiline {         --------------------多行格式
						pattern => "^\["     --------------------匹配以[开头的行做为分隔
						negate => true       
						what => "previous"                 
				}

			}
		}


		filter{

		}

		output{
		   if [type] == "system-log" {

			   elasticsearch {
				   hosts => ["10.0.0.11:9200"]
				   index => "system-log-%{+YYYY.MM}"
			   }
		   }
		   if [type] == "es-log" {
			   elasticsearch {
					 hosts => ["10.0.0.11:9200"]
					 index => "es-log-%{+YYYY.MM}"
			   }
		   }
		   stdout{
				 codec => rubydebug
		   }
		}
	
	
### 3.5 codec json格式 ###
	
		将nginx 日志格式改成json格式
		
		log_format log_json '{"user_ip":"$http_x_real_ip","lan_ip":"$remote_addr","log_time":"$time_iso8601","user_req":"$request","http_code":"$status","body_bytes_sent":"$body_bytes_sent","req_time":"$request_time","user_ua":"$http_user_agent","x_forwarded":"$http_x_forwarded_for"}'; 


		logstash文件：
		
		input{
			file{
				path => ["/var/log/messages","/var/log/secure"]
				type => "system-log"
				start_position => "beginning"
			}
			
			file{
				path => ["/var/log/elasticsearch/myes.log"]
				type => "es-log"
				start_position => "beginning"
				codec => multiline {
						pattern => "^\["
						negate => true
						what => "previous"                 
				}

			}
			
			file{
				path => "/var/log/nginx/nginx_access.log"
				type => "nginx-accesslog"
				start_position => "beginning"
				codec => "json" -----------------为json格式
			}

		}


	filter{

	}

	output{
	   if [type] == "system-log" {

		   elasticsearch {
			   hosts => ["10.0.0.11:9200"]
			   index => "system-log-%{+YYYY.MM}"
		   }
	   }
	   if [type] == "es-log" {
		   elasticsearch {
				 hosts => ["10.0.0.11:9200"]
				 index => "es-log-%{+YYYY.MM}"
		   }
	   }

	   if [type] == "nginx-accesslog" {
		   elasticsearch {
				 hosts => ["10.0.0.11:9200"]
				 index => "nginx-accesslog-%{+YYYY.MM.dd}"
		   }
	   }
	   stdout{
			 codec => rubydebug
	   }
	}

		
		



	

	
	
