#!/bin/sh
#####################################################
##
## 로그 상태 저장 Shell
##
#####################################################

# $* is All Parameters

export SMS_SENDER_HOME="/home/sms/seeSys/seeSysAgent"
export JAVA_HOME="/usr/local/java/"
export CLASSPATH="$JAVA_HOME/lib/tools.jar"
export PATH="$JAVA_HOME/bin:$PATH"

SMS_SENDER_CLASSPATH="."


for jarfile in $SMS_SENDER_HOME/lib/*.jar; do
  SMS_SENDER_CLASSPATH=$SMS_SENDER_CLASSPATH:$jarfile
done

SMS_SENDER_CLASSPATH=$SMS_SENDER_CLASSPATH:$SMS_SENDER_HOME/bin


export SMS_SENDER_CLASSPATH="$SMS_SENDER_CLASSPATH:$CLASSPATH"

#logdt=`date +%G%m%d`
#logtm=`date +%H%M%S`
#echo './seeSysLogAgent.sh' $* %logtm >> $SEESYSTEM_LOG_AGENT_HOME/log/seeSysLogAgent_$logdt.log
#java -cp "$SMS_SENDER_CLASSPATH" -Dlog4j.configuration=log4j.xml kr.co.indisystem.swfc.sms.SmsApp "$@" date:$logdt$logtm

java -cp "$SMS_SENDER_CLASSPATH" -Dlog4j.configuration=log4j.xml kr.co.indisystem.swfc.sms.SmsApp "$@"