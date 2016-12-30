# Yarn

## 安装

### Debian

先执行

```shell
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```
然后

`sudo apt-get update && sudo apt-get install yarn`

### Mac

先执行

```shell
brew update
brew install yarn
```

然后加入PATH中

### 版本验证

 > yarn --version
 
 
 ### yarn使用
 
 yarn [command] [flags]
 
 ```shell
  command:
    - access
    - add  添加
    - bin  执行脚本
    - cache 缓存
    - check 检查环境
    - clean 清理缓存
    - config 配置项目信息
    - generate-lock-entry
    - global 全局
    - info 查看项目信息
    - init 初始化
    - install 安装
    - licenses 查看证书
    - link
    - login 登录
    - logout 登出
    - ls
    - outdated
    - owner
    - pack  打包
    - publish  发布
    - remove 移除
    - run  运行
    - self-update 更新
    - tag 打标签
    - team
    - unlink 移除依赖
    - upgrade 升级
    - version 参看版本
    - why
```
 
## 使用

添加

1. yarn add package-name

2. yarn add <git remote url>

3. yarn global add <package...>
 
## 参考

![相关链接](https://yarnpkg.com/en/docs/install#linux-tab)


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)