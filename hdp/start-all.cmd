REM Just an example, you can create your own

SET HADOOP_HOME=c:\hdp\hadoop
SET HIVE_HOME=c:\hdp\hive
SET HADOOP_PREFIX=c:\hdp\hadoop2
SET HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoo
SET YARN_CONF_DIR=%HADOOP_CONF_DIR%
SET PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%\bin

REM format hdfs
REM only need to be run once
REM %HADOOP_HOME%\bin\hdfs namenode -format

REM to start dfs 
%hadoop_home%\sbin\start-dfs.cmd

REM start yarn
%hadoop_home%\sbin\start-yarn.cmd

REM start hive server 2
%hive_home%\bin\hive --service hiveserver2

REM start hive client
REM hive
