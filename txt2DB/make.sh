#!/bin/sh

SAT_IMG_MAKE_PGM_PATH=/TMAX/app/txtToDB
JAVA_PATH=/TMAX/app/picaso/jre/bin

PGM_APP_MAIN=kr.co.indisystem.nmsc.component.dbinsert.DbInsert

PRM_CLASSPATH="."

for jarfile in $SAT_IMG_MAKE_PGM_PATH/lib/*.jar; do
  PRM_CLASSPATH=$PRM_CLASSPATH:$jarfile
done

PRM_CLASSPATH=$PRM_CLASSPATH:$SAT_IMG_MAKE_PGM_PATH/bin

cd $SAT_IMG_MAKE_PGM_PATH/bin

$JAVA_PATH/java -cp $PRM_CLASSPATH $PGM_APP_MAIN "$@"
