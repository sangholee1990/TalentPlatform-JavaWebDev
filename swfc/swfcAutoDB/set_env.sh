#!/bin/sh
# seeSys environment set batch file.  

export LANG=ko_KR.euckr
export NLS_LANG=AMERICAN_AMERICA.KO16KSC5601

export JAVA_HOME=$SEE_SYS_PATH/jdk1.6.0_29
echo JAVA_HOME=$JAVA_HOME

# For differnt JAVA version
export CLASSPATH="$JAVA_HOME/lib/tools.jar"
echo CLASSPATH=$CLASSPATH

# For differnt JAVA version
export PATH="$JAVA_HOME/bin:$PATH"
echo PATH=$PATH

if [ ! -d "$SEE_SYS_HOME" ]; then
  echo SEE_SYS_HOME does not exist as a valid directory : $SEE_SYS_HOME
  echo Defaulting to current directory
  #SEE_SYS_HOME=.
  SEE_SYS_HOME=$SEE_SYS_PATH
fi

echo SEE_SYS_HOME=$SEE_SYS_HOME
echo ------------------------------------------------------------


SEE_SYS_CLASSPATH="."

for jarfile in $SEE_SYS_HOME/lib/*.jar; do
  SEE_SYS_CLASSPATH=$SEE_SYS_CLASSPATH:$jarfile
done

export SEE_SYS_CLASSPATH="$SEE_SYS_CLASSPATH:$SEE_SYS_HOME/bin"
export SEE_SYS_CLASSPATH="$SEE_SYS_CLASSPATH:$CLASSPATH"

export SEE_SYS_CLASSPATH="$SEE_SYS_CLASSPATH;$JAVA_HOME/lib/"

cd $SEE_SYS_PATH/bin
