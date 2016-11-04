# OSI协议

开放式系统互联通信参考模型（英语：Open System Interconnection Reference Model，缩写为 OSI），简称为OSI模型（OSI model），
一种概念模型，由国际标准化组织（ISO）提出，一个试图使各种计算机在世界范围内互连为网络的标准框架

### 应用层

提供为应用软件而设的界面，以设置与另一应用软件之间的通信。例如: HTTP，HTTPS，FTP，TELNET，SSH，SMTP，POP3等

### 表示层

把数据转换为能与接收者的系统格式兼容并适合传输的格式

### 会话层
负责在数据传输中设置和维护电脑网络中两台电脑之间的通信连接

### 传输层

把传输表头(TH)加至数据以形成数据包。传输表头包含了所使用的协议等发送信息。例如:传输控制协议义(TCP)，用户数据报协议(UDP)

### 网络层

决定数据的路径选择和转寄，将网络表头(NH)加至数据包，以形成分组。网络表头包含了网络数据。例如:互联网协议(IP)

### 数据链路层

负责网络寻址、错误侦测和改错。当表头和表尾被加至数据包时，会形成了帧。数据链表头(DLH)是包含了物理地址和错误侦测及改错的方法。
数据链表尾(DLT)是一串指示数据包末端的字符串。例如以太网、无线局域网(Wi-Fi)和通用分组无线服务(GPRS)等。分为两种子层：logic 
link control sublayer & media access control sublaye

### 物理层

在局部局域网上传送帧，它负责管理电脑通信设备和网络媒体之间的互通。包括了针脚、电压、线缆规范、集线器、中继器、网卡、主机适配器等


### TCP/IP三次握手

第一次握手：建立连接时，客户端发送syn包（syn=j）到服务器，并进入SYN_SENT状态，等待服务器确认；SYN：同步序列编号（Synchronize Sequence Numbers）

第二次握手：服务器收到syn包，必须确认客户的SYN（ack=j+1），同时自己也发送一个SYN包（syn=k），即SYN+ACK包，此时服务器进入SYN_RECV状态；

第三次握手：客户端收到服务器的SYN+ACK包，向服务器发送确认包ACK(ack=k+1），此包发送完毕，客户端和服务器进入ESTABLISHED（TCP连接成功）状态，完成三次握手

### 常见协议

HTTP

HTTP是客户端浏览器或其他程序与Web服务器之间的应用层通信协议。

Socket

网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket。
根据连接启动的方式以及本地套接字要连接的目标，套接字之间的连接过程可以分为三个步骤：服务器监听，客户端请求，连接确认。

```
（1）服务器监听：是服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态。
（2）客户端请求：是指由客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
（3）连接确认：是指当服务器端套接字监听到或者说接收到客户端套接字的连接请求，它就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，连接就建立好了。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。
```

TCP

TCP三次握手的过程如下：

```
 客户端发送SYN（SEQ=x）报文给服务器端，进入SYN_SEND状态。
 服务器端收到SYN报文，回应一个SYN （SEQ=y）ACK(ACK=x+1）报文，进入SYN_RECV状态。
 客户端收到服务器端的SYN报文，回应一个ACK(ACK=y+1）报文，进入Established状态。
```

三次握手完成，TCP客户端和服务器端成功地建立连接，可以开始传输数据了。

UDP

UDP提供了无连接通信，且不对传送数据包进行可靠性保证，适合于一次传输少量数据，UDP传输的可靠性由应用层负责。


WebSocket


WebSocket protocol 是HTML5一种新的协议。它实现了浏览器与服务器全双工通信(full-duplex)。一开始的握手需要借助HTTP请求完成,完成之后通过TCP进行端对端的通信传输。


Nginx反向代理websocket

```
location /websocket/ {
    proxy_pass http://swoole.php;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
}
```



[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)