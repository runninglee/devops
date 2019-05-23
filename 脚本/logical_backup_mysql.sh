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


#------------------------------------------------------------------------
TIME=`date +%Y%m%d%H`

MYSQL_PORT=3307
LOGICAL_BACKUP_DIR=/data/backup/logical_backup

cd $LOGICAL_BACKUP_DIR
function backup_mysql {
for dbname in $1 $2 $3 $4 $5 $6 $7 $8 
do
/usr/local/mysql/bin/mysqldump -uroot -p"mysqlpasswd"   $dbname > $LOGICAL_BACKUP_DIR/${dbname}_$TIME.sql
tar zcvf ${dbname}_$TIME.sql.tar.gz ${dbname}_$TIME.sql
rm ${dbname}_$TIME.sql -f
#find $LOGICAL_BACKUP_DIR -ctime +30 -exec rm -fr {} \;
find /data/backup/logical_backup/ -ctime +10 -exec rm -fr {} \;
done
}

backup_mysql db1 db2 db3 ......

