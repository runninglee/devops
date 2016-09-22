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

* 命令```userdel，groupdel```

* 详情查看```man + {userdel|groupdel}```


```
    "TODO"
```


#####  修改用户及用户组

* ```usermod```，```dscl```, 用于修改用户

* 详细见 ```man usermod```

```
    常用参数
       -c, --comment COMMENT
           The new value of the user's password file comment field. It is normally
           modified using the chfn(1) utility.
          "更新用户的配置文件的描述信息为COMMENT"

       -d, --home HOME_DIR
           The user's new login directory.
           If the -m option is given, the contents of the current home directory will
           be moved to the new home directory, which is created if it does not already
           exist.
           "指定用户的登陆目录为HOME_DIR"

       -e, --expiredate EXPIRE_DATE
           The date on which the user account will be disabled. The date is specified
           in the format YYYY-MM-DD.

           An empty EXPIRE_DATE argument will disable the expiration of the account.

           This option requires a /etc/shadow file. A /etc/shadow entry will be created
           if there were none.
           "设置用户登陆的过期时间，时间格式为YYYY-MM-DD，如果EXPIRE_DATE参数为空，将禁止设置用户过期时间"
         
       -f, --inactive INACTIVE
           The number of days after a password expires until the account is permanently disabled.

           A value of 0 disables the account as soon as the password has expired, and a value of -1
           disables the feature.

           This option requires a /etc/shadow file. A /etc/shadow entry will be created if there were none.

       -g, --gid GROUP
           Any file from the user's home directory owned by the previous primary group of the user will be
           owned by this new group.

           The group ownership of files outside of the user's home directory must be fixed manually.
           "指定用户所属组为GROUP，且GROUP必须存在，该用户所属组下面的家目录的文件所有权将被GROUP拥有"
           
           -G, --groups GROUP1[,GROUP2,...[,GROUPN]]]
           A list of supplementary groups which the user is also a member of. Each group is separated from
           the next by a comma, with no intervening whitespace. The groups are subject to the same
           restrictions as the group given with the -g option.

           If the user is currently a member of a group which is not listed, the user will be removed from
           the group. This behaviour can be changed via the -a option, which appends the user to the
           current supplementary group list.

       -l, --login NEW_LOGIN
           The name of the user will be changed from LOGIN to NEW_LOGIN. Nothing else is changed. In
           particular, the user's home directory or mail spool should probably be renamed manually to
           reflect the new login name.

       -L, --lock
           Lock a user's password. This puts a '!' in front of the encrypted password, effectively
           disabling the password. You can't use this option with -p or -U.

           Note: if you wish to lock the account (not only access with a password), you should also set the
           EXPIRE_DATE to 1.

       -m, --move-home
           Move the content of the user's home directory to the new location.

           This option is only valid in combination with the -d (or --home) option.

           usermod will try to adapt the ownership of the files and to copy the modes, ACL and extended
           attributes, but manual changes might be needed afterwards.

       -o, --non-unique
           When used with the -u option, this option allows to change the user ID to a non-unique value.

       -p, --password PASSWORD
           The encrypted password, as returned by crypt(3).

           Note: This option is not recommended because the password (or encrypted password) will be
           visible by users listing the processes.

           The password will be written in the local /etc/passwd or /etc/shadow file. This might differ
           from the password database configured in your PAM configuration.

           You should make sure the password respects the system's password policy.

       -R, --root CHROOT_DIR
           Apply changes in the CHROOT_DIR directory and use the configuration files from the CHROOT_DIR
           directory.
           
            -s, --shell SHELL
           The name of the user's new login shell. Setting this field to blank causes the system to select
           the default login shell.

       -u, --uid UID
           The new numerical value of the user's ID.

           This value must be unique, unless the -o option is used. The value must be non-negative.

           The user's mailbox, and any files which the user owns and which are located in the user's home
           directory will have the file user ID changed automatically.

           The ownership of files outside of the user's home directory must be fixed manually.

           No checks will be performed with regard to the UID_MIN, UID_MAX, SYS_UID_MIN, or SYS_UID_MAX
           from /etc/login.defs.
```

* ```groupmod```，用户修改用户组


* 详细见```man groupmod```

```
常用参数

       -g, --gid GID
           The group ID of the given GROUP will be changed to GID.

           The value of GID must be a non-negative decimal integer. This value must be
           unique, unless the -o option is used.

           Users who use the group as primary group will be updated to keep the group as
           their primary group.

           Any files that have the old group ID and must continue to belong to GROUP,
           must have their group ID changed manually.

           No checks will be performed with regard to the GID_MIN, GID_MAX, SYS_GID_MIN,
           or SYS_GID_MAX from /etc/login.defs.

       -n, --new-name NEW_GROUP
           The name of the group will be changed from GROUP to NEW_GROUP name.

       -o, --non-unique
           When used with the -g option, allow to change the group GID to a non-unique
           value.

       -p, --password PASSWORD
           The encrypted password, as returned by crypt(3).

           Note: This option is not recommended because the password (or encrypted
           password) will be visible by users listing the processes.

          You should make sure the password respects the system's password policy.

```

###### usermod案列

1. 修改用户名

> usermod -l new_name

2. 修改密码

> usermod -p new_password

3. 变更所属组

> usermod -g exist_group

4. 设置家目录

> usermod -d new_home

5. 综合(变更用户到nginx组，同时设置家目录为website，更新ssh密码)

> usermode -g nginx -d website -p ssh_password

###### groupmod案列

1. 修改组名

> groupmod -g new_group_name


[Contanct Me](mailto:lihui870920@gmail.com)