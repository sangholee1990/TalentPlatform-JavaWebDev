#!/bin/sh
# -----------------------------------------------------------------------------
# Run Script for SWFCBatch
#
# $Id$
# -----------------------------------------------------------------------------

BATCH_HOME=/home/batch
JAVA_HOME=/usr

# Make sure prerequisite environment variables are set
if [ -z "$JAVA_HOME" ]; then
  echo "The JAVA_HOME environment variable is not defined"
  echo "This environment variable is needed to run this program"
  exit 1
fi

if [ ! -r "$JAVA_HOME"/bin/java ]; then
  echo "The JAVA_HOME environment variable is not defined correctly"
  echo "This environment variable is needed to run this program"
  exit 1
fi

# Set standard commands for invoking Java.
_RUNJAVA="$JAVA_HOME"/bin/java

if [ ! -r "$BATCH_HOME"/SWFCBatch.jar ]; then
  echo "The BATCH_HOME environment variable is not defined correctly"
  echo "This environment variable is needed to run this program"
  exit 1
fi

# if not told otherwise pump up the permgen
if [ -z "$JAVA_OPTS" ]; then
  export JAVA_OPTS="-XX:MaxPermSize=128m"
fi 

cd "$BATCH_HOME"

exec "$_RUNJAVA" $JAVA_OPTS -Djava.awt.headless=true -Djava.library.path="$BATCH_HOME/lib/cxform" -jar SWFCBatch.jar -t $1 