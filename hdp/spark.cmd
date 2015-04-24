


SET SPARK_HOME=c:\hdp\spark

REM start spark SQL on yarn interactively
%spark_home%\bin\spark-sql.cmd --master yarn-client

REM submit an spark app to the cluster, in this case, thrift server start spark thrift
%spark_home%\bin\spark-submit.cmd --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --master yarn-custer spark-internal
