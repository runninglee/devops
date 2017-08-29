#!/bin/bash
# wangwei
# 1046679050@qq.com
# codis-dashboa process manager script

DIR=/usr/local/codis/bin
CODIS_STATUS=`netstat -lntp|grep codis-dashboa|wc -l`
USAGE(){

    echo "$0:{start|stop}"

}
codis_start(){

    if [ $CODIS_STATUS -eq 1 ];
      then
         echo "codis-dashboa is already running"
      else
         cd $DIR &&
         nohup $DIR/codis-dashboard --config=/usr/local/codis/config/dashboard.conf --log=/usr/local/codis/log/dashboard.log --log-level=WARN  >/dev/null 2>&1 &
    fi

}

codis_stop(){
    if [ $CODIS_STATUS -eq 1 ];
       then
        pkill codis-dashboa &&
        CODIS_STATUS2=`netstat -lntp|grep codis-dashboa|wc -l`
        if [ $CODIS_STATUS2 -eq 0 ];
         then
           echo "codis-dashboa is stopped"
        fi
      else
        echo "codis-dashboa stopped faild" 

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
