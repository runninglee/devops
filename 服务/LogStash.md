#LogStash

Logstash 是开源的服务器端数据处理管道，能够同时从多个来源采集数据，转换数据，然后将数据发送到您最喜欢的“存储库”中

# 安装

`$ brew install logstash`

`$ brew services start logstash`

# 测试

`$ logstash -e 'input{stdin{}}output{stdout{codec=>rubydebug}}'`

输入

`$ Hello World`

输出

```json5
{
    "@timestamp" => 2019-10-08T14:04:46.407Z,
    "host" => "HuiLee-MacBook",
    "@version" => "1",
    "message" => "hello world"
}


```



