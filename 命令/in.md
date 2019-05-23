### in

in 链接命令，为某一个文件在另一个位置建立一个不同的链接。

### 应用场景

终端命令下安装的服务在执行的过程中，发现找不到这个命令，其实是安装的执行文件没有把路径映射到系统可执行目录中

解决的办法可以建立软链接，也可以导入服务执行文件的路径。


### 创建命令

in [params] bin_path sys_path

params:

-s: 进行软链接
-f: 删除已经存在的同名档案,新建链接

### 删除命令

rm sys_path


### 演示

* 创建taro,ionic,codova

    `ln -f -s ~/.config/yarn/global/node_modules/@tarojs/cli/bin/taro /usr/local/bin/taro`
    
    `ln -f -s /Users/huilee/lib/node_modules/ionic/bin/ionic /usr/local/bin/ionic`
    
    `ln -f -s  /Users/huilee/Panda.App/lib/node_modules/cordova/bin/cordova /usr/local/bin/cordova`

* 删除taro,ionic,cordova

    `rm /usr/local/bin/taro`
    
    `rm /usr/local/bin/ionic`
    
    `rm /usr/local/bin/cordova`
    
    
