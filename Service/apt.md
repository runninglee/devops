# apt

Debian/Ubuntu软件管理包

 ## 使用方式
 
 升级
 
  > apt-get update && apt-get upgrade
  
 更新
 
 > apt-get update
 
 安装
 
 > apt-get install package=version
 
 移除
 
 > apt-get remove package

升级到最新版本

> apt-get -u dist-upgrade

安装最新版本

> apt-get -u install package

移除无用软件包文件

> apt-get clean 或 autoclean

搜索软件包

> apt-cache search package


#Relation

[Debian](https://www.debian.org/doc/manuals/apt-howto/ch-apt-get.zh-cn.html)

#License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)