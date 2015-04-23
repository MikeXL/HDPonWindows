#### Just an example, you can create your own

SET HADOOP_HOME=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-000
SET HIVE_HOME=E:\hdp-2.2.4.2\hive-0.14.0.2.2.4.2-0002
SET HADOOP_PREFIX=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002
SET HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoo
SET YARN_CONF_DIR=%HADOOP_CONF_DIR%
SET PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%/bin

#### format hdfs
# %HADOOP_HOME%\bin\hdfs namenode -format

#### to start dfs 
# start-dfs

#### start yarn
# start-yarn

#### start hive server 2
# %hive_home%\bin\hive --service hiveserver2

#### start hive client
# hive
