# [Laravel+Kafka(MacOS)](https://xynania.github.io/laravel-kafka/)

Laravel框架下使用Kafka实现异步消息队列，协助业务分离，提升页面体验。

## 应用场景

1. 错峰流控和流量削峰

用于秒杀,抢团活动过程中,削弱流量,防止暴增带来的服务挂机.

2. 行为分析

用于系统用户的行为日志跟踪,结合数据分析,提供推荐.

3. 异步通信

调整串行业务为并行异步方式(用户注册成功,可同时发邮件和发短信)

4. 日志同步

日志采集到 Kafka 消息队列中,然后同步到 ElasticSearch 中

5. 消息队列

支持事务消息队列

### 部署

##### Zookeeper服务

- 安装

    `brew install zookeeper`
- 管理

    推荐方式

    `brew services start zookeeper`

    手动方式

    `zkService start`

##### Kafka服务

- 安装

    `brew install kafka`
    
- 管理

    推荐方式

    `brew services start kafka`
    
    手动方式

    `zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties & kafka-server-start /usr/local/etc/kafka/server.properties`


##### 安装PHP驱动Kafka

- PHP扩展rdkafka

    自动(目前官方支持到7.1)

    `brew install homebrew/php/php71-rdkafka`

    手动(7.2.X需要手动编译)

    [源码编译](https://arnaud.le-blanc.net/php-rdkafka/phpdoc/rdkafka.installation.manual.html)

    ```bash
    $ git clone https://github.com/arnaud-lb/php-rdkafka.git
    $ cd php-rdkafka
    $ phpize
    $ ./configure
    $ make && make install
    ```
    
    安装过程中可能遇到缺少类库问题，请先安装librdkafka类库

    ```bash
    $ git clone https://github.com/edenhill/librdkafka.git
    $ cd librdkafka
    $ ./configure
    $ make && make install
    ```

### Laravel管理Kafka

1. 创建topic

`php artisan kafka:run-topic`

2. 创建producer

 `php artisan kafka:producer`

3. 创建consumer

`php artisan kafka:consumer`

### Laravel 运行脚本

1. 命令行下执行消费者


2. 命令行下执行生产者


3. Web方式运行

```bash

yarn

php artisan serve

```

---

### Kafka 脚本

#### 名词

--producer

消息生产者,产生的消息将会被发送到toipc,客户端的发布方

--consumer

消息消费者,消息的消息内容来自topic,服务端的订阅方

--topic

消息分类,物理目录,同一个主题归类到同一个目录

--broker

一个Kafka实例(Kafka服务节点),一个broker可以有多个topic

--partition

broker上的物理分区, 一个topic可以分为多个分片


#### 主题管理

--bootstrap-server

主机

--partitions

分区

--replication-factor

副本

主题命令

`kafka-topics man`

主题详情

`kafka-topics --describe --bootstrap-server 127.0.0.1:9092 --topic test`

主题列表

`kafka-topics --list --bootstrap-server localhost:9092`

创建主题

`kafka-topics --create --topic test1 --bootstrap-server 127.0.0.1:9092 --partitions 1 --replication-factor 1`

修改主题

`kafka-topics --alter --topic test2 --partitions 2 --bootstrap-server 127.0.0.1:9092`

删除主题

`kafka-topics --delete --topic test1 --bootstrap-server 127.0.0.1:9092`

#### 消费者管理

消费者命令

`kafka-console-consumer man`

消费消息

`kafka-console-consumer --topic test --from-beginning --bootstrap-server 127.0.0.1:9092`

#### 生产者管理

生产者命令

`kafka-console-producer man`

生产消息

`kafka-console-producer --topic test --broker-list 127.0.0.1:9092`

#### 消费组管理

消费组命令

`kafka-consumer-groups man`

消费组

`kafka-consumer-groups --bootstrap-server 127.0.0.1:9092 --describe --all-groups`

---

### Laravel 脚本

**主题**

* 创建主题

	`php artisan kafka:create-topic`

* 删除主题

	`php artisan kafka:delete-topic`

* 检查主题

	`php artisan kafka:check-topic`

* 主题列表

	`php artisan kafka:list-topic`


**生产者**

* 脚本方式
	
`php artisan kafka:produce-producer`

* 网页方式

```php
 ( new ProducerTopic() )->produce('test2', ['key' => now()->timestamp.now()->microsecond, 'msg' => 'Hello World']);
```

**消费者**

 `php artisan kafka:consume-consumer`

### 问题汇总

1. 单机环境下的Kafka队列消化能力比较弱



