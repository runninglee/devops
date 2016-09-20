### 用户管理

---

##### 添加用户和用户组



 * Linux/Unix适用于多用户，可以共享资源，独立操作，隔离用户行为；
 
 * 使用```man useradd```查看本系统下的命令帮助手册


```
常用选项
       --conf FILE
              Use FILE instead of /etc/adduser.conf.()
              "使用FILE替换默认配置"

       --disabled-login
              Do not run passwd to set the password.  The user won't be able to use her account until the password is set.
              "用户无法设置密码，无法登陆，除非帐户设置过密码"
       --group
              When  combined  with  --system,  a group with the same name and ID as the system user is created.  If not combined with --system, a group with the
              given name is created.  This is the default action if the program is invoked as addgroup.
             "如果结合--system命令使用的时候，将会创建跟该组同名的系统组和系统用户；如果单独使用，默认添加一个组"
       --home DIR
              Use DIR as the user's home directory, rather than the default specified by the configuration file.  If the directory does not exist, it is created
              and skeleton files are copied.
              "使用DIR作为用户根目录，后者使用默认配置文件；如果根目录不存在，将会被创建，同时复制用户必须文件到DIR中"
       --shell SHELL
              Use SHELL as the user's login shell, rather than the default specified by the configuration file.
              "指定用户登陆时使用的shell脚本，否则使用默认配置"
       --ingroup GROUP
              Add the new user to GROUP instead of a usergroup or the default group defined by USERS_GID in the configuration file.  This affects the users pri-
              mary group.  To add additional groups, see the add_extra_groups option
              "添加新用户到声明的GROUP中或已存在的用户组，该组将变成用户的主要所属组，添加其余的住，见add_extra_groups参数"
       --no-create-home
              Do not create the home directory, even if it doesn't exist.
              "不管存不存在用户根目录，都不创建"
       --quiet
              Suppress informational messages, only show warnings and errors.'
              "静默模式，只有出现警告或错误的时候提示信息"
       --debug
              Be verbose, most useful if you want to nail down a problem with adduser.
              "详细输出使用adduser过程中出现的重要错误信息"
       --system
              Create a system user or group.
              "创建系统用户和组"      
       --uid ID
              Force the new userid to be the given number.  adduser will fail if the userid is already taken.
              "按制定变量增加用户ID，如果用户ID存在，则添加失败"      
       --firstuid ID
              Override the first uid in the range that the uid is chosen from (overrides FIRST_UID specified in the configuration file).
              "覆盖系统列表中第一个用户ID"      
       --lastuid ID
              Override the last uid in the range that the uid is chosen from ( LAST_UID )
              "覆盖系统列表中最后一个用户ID"      
       --add_extra_groups
              Add new user to extra groups defined in the configuration file.
              "添加用户到其他的组中"
       --version
              Display version and copyright information.
              "显示版本和版权信息"

```

###### 案例

系统开新账户，并且该用户管理自己的文件，最常见的项目部署

> useradd git-project

```
"系统创建用户，用户组及用户家目录，一次完成"

```


##### 删除用户和用户组

* ```userdel```,```groupdel```

* 详情查看```man + {userdel|groupdel}```


#####  修改用户及用户组

* ```usermod```，用于修改用户
* 详细见 ```man usermod```
* ```groupmod```，用户修改用户组
* 详细见```man groupmod```


###### 案列

#### TODO