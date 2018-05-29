## 一、安装nfs和rpcbind服务 ##
    rpcbind ：端口注册服务
	nfs-kernel-server: nfs服务
	
	安装：
	      apt-get install rpcbind
	      apt-get install nfs-common nfs-kernel-server -y
		  
## 二、创建nfs服务共享目录 ##
    注意：
	    ERP系统代码目录为需提供共享挂载的目录
	代码目录：
        /home/erp/wangwei/erp/
		
## 三、创建nfs配置文件 ##		
    /etc/exports
	erp@debian:~$ cat /etc/exports 
	# /etc/exports: the access control list for filesystems which may be exported
	#		to NFS clients.  See exports(5).
	#
	# Example for NFSv2 and NFSv3:
	# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
	#
	# Example for NFSv4:
	# /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
	# /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
	/home/erp/wangwei/erp 10.0.0.0/24(rw,anonuid=1004,anongid=1004,all_squash,sync)
	
    	配置解释：
    	/home/erp/wangwei/erp  共享挂载的目录
    	10.0.0.0/24  提供挂载访问的ip地址范围
    	rw：与ro 相反 为读写权限
    	anonuid：挂载用户id
    	anongid: 挂载用户组id
    	all_squash：不管用户是谁都压缩为匿名用户
    	sync: 实时同步

## 四：启动nfs服务 ##
    注意：
	    nfs服务启动需要向rpcbind服务注册服务端口，所以rpcbind服务要优先启动
	/etc/init.d/rpcbind start
	/etc/init.d/nfs-kernel-server start
## 
五：挂载nfs共享文件系统 ##

    使用showmount -e 查看服务端提供的nfs服务目录
    root@debian:~# showmount -e 10.0.0.11   ------------------- 使用showmount -e 查看服务端提供的nfs服务目录
	Export list for 10.0.0.11:
	/home/erp/wangwei/erp 10.0.0.0/24
	
	使用mount命令挂载nfs文件系统
	mount -t nfs 10.0.0.11:/home/erp/wangwei/erp /home/erp/wangwei/erp -o proto=tcp -o nolock
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
