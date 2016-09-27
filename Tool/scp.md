# scp

基于的安全拷贝文件程序，使用SSH进行数据传输，并且使用跟SSH一样的认证方式

## Usage

格式：

scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file] [-l limit] [-o ssh_option] [-P port] [-S program] [[user@]host1:]file1 ...[[user@]host2:]file2

案列：

* 下载远程数据库备份文件到本地

> scp demo@127.98.21.12:/demo/backup/demo.sql /home/download/

下载demo.sql文件到home目录下的download文件中

* 本地上传远程服务器

> scp ~/download/demo.sql demo@127.98.21.12:/demo/backup/

上传本地demo.sql文件到远程服务器上

* 计划任务

> 使用计划任务，定时往目标服务器推送数据


## History

* 基础的数据交换
* TODO: 结合同步脚本，做一键式备份下载


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)