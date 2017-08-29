#!/bin/bash
# wangwei
# 1046679050@qq.com
# codis-fe process manager script

DIR=/usr/local/codis/bin
CODIS_STATUS=`netstat -lntp|grep codis-fe|wc -l`
USAGE(){

    echo "$0:{start|stop}"

}
codis_start(){

    if [ $CODIS_STATUS -eq 1 ];
      then
         echo "codis-fe is already running"
      else
         cd $DIR &&
         nohup $DIR/codis-fe --ncpu=2 --log=/usr/local/codis/log/fe.log --log-level=WARN --dashboard-list=/usr/local/codis/config/codis.json --listen=0.0.0.0:18090  >/dev/null 2>&1 &
    fi

}

codis_stop(){
    if [ $CODIS_STATUS -eq 1 ];
      then
        pkill codis-fe &&
        CODIS_STATUS2=`netstat -lntp|grep codis-fe|wc -l`
        if [ $CODIS_STATUS2 -eq 0 ];
         then
           echo "codis-fe is stopped"
        fi
      else
        echo "codis-fe stopped faild" 

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
