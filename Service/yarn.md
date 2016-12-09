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
 
 
## 参考

![相关链接](https://yarnpkg.com/en/docs/install#linux-tab)


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)