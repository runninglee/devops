#!/bin/bash
# wangwei
# 1046679050@qq.com
# redis-sentine process manager script

DIR=/usr/local/codis/bin
CODIS_STATUS=`netstat -lntp|grep redis-sentine|wc -l`
USAGE(){

    echo "$0:{start|stop}"

}
codis_start(){

    if [ $CODIS_STATUS -eq 1 ];
      then
         echo "redis-sentine is already running"
      else
         cd $DIR &&
         nohup $DIR/redis-sentinel /usr/local/codis/config/sentinel.conf >/dev/null 2>&1 &
    fi

}

codis_stop(){
    if [ $CODIS_STATUS -eq 1 ];
       then
        pkill redis-sentine &&
        CODIS_STATUS2=`netstat -lntp|grep redis-sentine|wc -l`
        if [ $CODIS_STATUS2 -eq 0 ];
         then
           echo "redis-sentine is stopped"
        fi
      else
        echo "redis-sentine stopped faild" 

    fi
}


case $1 in
     start)
          codis_start
          ;;
     stop)
          codis_stop
          ;;
       *)
          USAGE
esac
