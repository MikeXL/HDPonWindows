


SET SPARK_HOME=c:\hdp\spark

REM start spark SQL on yarn interactively
%spark_home%\bin\spark-sql.cmd --master yarn-client

REM submit an spark app to the cluster, in this case, thrift server start spark thrift
%spark_home%\bin\spark-submit.cmd --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --master yarn-custer spark-internal


SPARK_HOME/conf/hive-site.xml

<configuration>
<property>
  <name>hive.metastore.uris</name>
  <value>thrift://sandbox.hortonworks.com:9083</value>
  <description>URI for client to contact metastore server</description>
</property>
</configuration>



$ hive --hiveconf hive.metastore.uris="thrift://your_hive_server:9083" --hiveconf hive.metastore.local=false
Make sure the Hive server host name or IP address and Thrift port is correct for your Hadoop installation. For Cloudera 4, Hortonworks 1.2, and MapR installations the default Thrift port is 9083.
  For Hortonworks 2 installations, it is 9983.
