#!/bin/sh
#####################################################
##
## 로그 상태 저장 Shell
##
#####################################################

# $* is All Parameters



#java -cp "$SMS_SENDER_CLASSPATH" -Dlog4j.configuration=log4j.xml kr.co.indisystem.swfc.sms.SmsApp "$@"

ssh gnssadmin@203.247.75.50 /data1/GNSS/gnssadmin/PROG/JAVA/SmsSender/smsSender.sh "$@"
exit