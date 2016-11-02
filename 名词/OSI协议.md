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

把传输表头(TH)加至数据以形成数据包。传输表头包含了所使用的协议等发送信息。例如:传输控制协议义(TCP) 

### 网络层

决定数据的路径选择和转寄，将网络表头(NH)加至数据包，以形成分组。网络表头包含了网络数据。例如:互联网协议(IP)

### 数据链路层

负责网络寻址、错误侦测和改错。当表头和表尾被加至数据包时，会形成了帧。数据链表头(DLH)是包含了物理地址和错误侦测及改错的方法。
数据链表尾(DLT)是一串指示数据包末端的字符串。例如以太网、无线局域网(Wi-Fi)和通用分组无线服务(GPRS)等。分为两种子层：logic 
link control sublayer & media access control sublaye

### 物理层

在局部局域网上传送帧，它负责管理电脑通信设备和网络媒体之间的互通。包括了针脚、电压、线缆规范、集线器、中继器、网卡、主机适配器等


### 三次握手


### 常见协议



[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)