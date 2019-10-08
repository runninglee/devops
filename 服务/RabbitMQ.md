消息队列

1.简单队列
2.分布式任务队列
3.发布订阅
4.选向路由接收
5.通配符过滤
6.RPC

https://www.rabbitmq.com/getstarted.html

https://github.com/php-amqplib/php-amqplib


秒杀思路：
1. 请求入Redis库限流
2. 监听Redis队列及时持久化到数据库
3. 秒杀业务处理



