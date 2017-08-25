#!/bin/bash

#-------------------------------------------------------------------------
#application:   mysql备份脚本
#Filename:	    logical_backup_mysql.sh
#Revision:	    0.1
#Date:		    2016/12/19
#Author:	    hanye
#Email:		    hz7726@164.com
#Website:	    www.1fangxin.cn
#Description:	Statistics of the top ten IP number and send email to author
#Notes:
#crontab:   59 23 * * *  logical_backup_mysql.sh    > /dev/null 2>&1
#------------------------------------------------------------------------

#Copyright:	2016 (c) fangxin
#License:	GPL


dateDIR=$(date -d "yesterday" +"%y-%m-%d")
mkdir -p /data/backup/mysql/binlog/$dateDIR
##刷新缓存中的日志
     mysqladmin -uroot -p flush-logs


#7天前的时间
     TIME=$(date "-d 7 day ago" +"%Y-%m-%d %H:%M:%S")


#24小时前的时间
     StartTime=$(date "-d 1 day ago" +"%Y-%m-%d %H:%M:%S")


#删除7天前的2进制文件
     mysql -uroot -p -e "purge master logs before '${TIME}';"


#针对每个数据库
     for db in $(mysql -uroot -p -e "show databases" | grep -e "zabbixdatabases" -e"serverdatabases")
     do
#针对所有的日志文件
      for log in $(cat /var/lib/mysql/mysql-bin.index)
      do
#备份每个数据库24小时之前到现在时间的所有日志，写入到相应文件中
     mysqlbinlog -uroot -p -d $db --start-datetime="$StartTime" ${log} > /data/backup/mysql/binlog/$dateDIR/${db}_${dateDIR}.sql
     done
     #tar jcvf /data/backup/mysql/binlog/$dateDIR/${db}_${dateDIR}.tar.bz2 /data/backup/mysql/binlog/$dateDIR/${db}_${dateDIR} 2&>/dev/null
     #rm -rf /data/backup/mysql/binlog/$dateDIR/${db}_${dateDIR}
    done
#删除20天以前的增量备份文件和目录
    find /data/backup/mysql/binlog/* -mtime +19 -type d -exec rm -rf {} \;