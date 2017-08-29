#!/bin/bash
# wangwei
# 1046679050@qq.com
# codis-server process manager script
CNUM=$#
DIR=/usr/local/codis
PORT=$1
CODIS_SERVER_STATUS=`netstat -lntp|grep -w "${PORT}"|wc -l`
USAGE(){
    if [ $CNUM -ne 2 ];
      then
        echo "$0:{PORT} {start|stop}"
    fi
}
codis_server_start (){
    if [ $CODIS_SERVER_STATUS -eq 1 ];
      then
         echo "codis-proxy is already running"
      else
         cd $DIR &&
         ${DIR}/bin/codis-server ${DIR}/config/redis_${PORT}.conf
    fi

}

codis_server_stop(){
    if [ $CODIS_SERVER_STATUS -eq 1 ];
       then
        CODIS_PID=$(ps -ef|grep -w "${PORT}"|grep -v 'grep'|awk '{print $2}')
        kill $CODIS_PID 
        CODIS_SERVER_STATUS2=`netstat -lntp|grep -w "${PORT}"|wc -l`
        if [ ${CODIS_SERVER_STATUS2} -eq 0 ];
           then
              echo "codis-server $PORT is stopped"
           else
              echo "codis-server $PORT is stopped faild"
        fi
    fi

}


case $2 in
     start)
          codis_server_start
          ;;
     stop)
          codis_server_stop
          ;;
       *)
          echo "$0:{PORT} {start|stop}"
esac
