#!/bin/bash
# wangwei
# 1046679050@qq.com
# codis-proxy process manager script

DIR=/usr/local/codis/bin
CODIS_STATUS=`netstat -lntp|grep codis-proxy|wc -l`
USAGE(){

    echo "$0:{start|stop}"

}
codis_start(){

    if [ $CODIS_STATUS -eq 2 ];
      then
         echo "codis-proxy is already running"
      else
         cd $DIR &&
         nohup $DIR/codis-proxy --ncpu=2 --config=/usr/local/codis/config/proxy.conf --log=/usr/localcodis/log/proxy.log --log-level=WARN  >/dev/null 2>&1 &
    fi

}

codis_stop(){
    if [ $CODIS_STATUS -eq 2 ];
       then
        pkill codis-proxy &&
        CODIS_STATUS2=`netstat -lntp|grep codis-proxy|wc -l`
        if [ $CODIS_STATUS2 -eq 0 ];
         then
           echo "codis-proxy is stopped"
        fi
      else
        echo "codis-proxy stopped faild" 

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
