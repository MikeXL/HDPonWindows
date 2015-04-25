# Install HDP on Windows

Here is how it works on either Windows 2008 R2 or Windows 10 (server technical preview). I'm mainly on latter on azure VM.  
The idea is quite simple *xcopy* type of deployment.

### 1. Prerequisites

- Python 2.7.6 x64 same as my Yosemite
- Java 1.8.0_45
- Viscual C++ 2010 SP1 Redistributable x64  
- Download hdp windows installer from hortonworks
- Unpack the msi to get the individual zip files


    msiexec /a hdp-x.x.x.x.msi /qn TARGETDIR=D:\
    


### 2. Find the HadoopInstallFiles and unzip hadoop, hive, spark then put then in

    c:\hdp\hadoop
    c:\hdp\hive
    c:\hdp\spark


### 3. Set environment variables
(path used as above sample, other than below, ensure python in the PATH and JAVA_HOME is set.)  

    SET HADOOP_HOME=C:\hdp\hadoop
    SET HIVE_HOME=C:\hdp\hive
    Set SPARK_HOME = C:\hdp\spark
    SET HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoop
    SET YARN_CONF_DIR=%HADOOP_CONF_DIR%
    SET PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%\bin


### 4. edit the xml configuration files
I have it uploaded

### 5. format HDFS namenode
    %HADOOP_HOME%\bin\hdfs namenode -format

### 6. start hadoop dfs
    %HADOOP_HOME%\sbin\start-dfs.cmd

### 7. start yarn
    %HADOOP_HOME%\sbin\start-yarn.cmd

then fire up your browser, type in the url, in my case http://unicorn:8088  
yes.

### 8. create hive data warehouse structure (folders) in hdfs

    %HADOOP_HOME%/bin/hadoop fs -mkdir       /tmp
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user/hive
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user/hive/warehouse
    %HADOOP_HOME%/bin/hadoop fs -chmod g+w   /tmp
    %HADOOP_HOME%/bin/hadoop fs -chmod g+w   /user/hive/warehouse


### 9. configure hive metastore (optional: as I am running in azure VM so why not use like to use SQL Azure)

1. Download SQL server JDBC and place it to %HIVE_HOME%\lib  
2. In SQL azure, create a new database for HIVE, and record the host and login information that needed in next step  
3. Checkout the hive-site.xml configuration file in the hdp/hive/conf folder in this repo for an example.  


### 10. start hive services

    %HIVE_HOME%\bin\hive --service hiveserver2  


### 11. Spark
It is as simple as placing [*yarn-client* or *yarn-cluster*][5] for the master parameter. And ensure the spark binary built with yarn support.  For instance, start pyspark.

    pyspark --master yarn-client


use yarn-master when submitting an spark app, for instance, Pi

    spark-submit --verbose ^
      --class org.apache.spark.examples.SparkPi ^
      --master yarn-cluster ^
      --num-executors 3 ^
      --driver-memory 512m ^
      --executor-memory 512m ^
      --executor-cores 1 ^
      %spark_home%/lib/spark-examples*.jar 10  


To start the thrift server on yarn, ensure the *hive-site.xml*

    %spark_home%\bin\spark-submit  ^
          --class  ^
              org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 ^
          --master yarn-client? spark-internal
          --hiveconf hive.server2.thrift.port=1170



### 12. hcatalog
I have to say wow, hcat.py works with double quotation. maybe it is the nature of windows command line. I just so used to single.

    %HCAT_HOME%\bin\hcat.py -e "desc mtcars"




[1]: https://wiki.apache.org/hadoop/Hadoop2OnWindows "Hadoop on Windows Wiki"
[2]: https://cwiki.apache.org/confluence/display/Hive/HiveDerbyServerMode#HiveDerbyServerMode-ConfigureHivetoUseNetworkDerby "Configure HIVE"
[3]: http://hortonworks.com/hadoop-tutorial/using-hive-data-analysis/ "Using Hive for Data Analysis"  
[4]: https://developer.ibm.com/hadoop/blog/2014/09/19/big-sql-3-0-file-formats-usage-performance/ "Good comparision of Hive storage format"  
[5]: http://blog.cloudera.com/blog/2014/05/apache-spark-resource-management-and-yarn-app-models/ "Spark yarn mode client vs master explained"  
[6]: http://hortonworks.com/hadoop-tutorial/using-apache-spark-hdp/ "Using Apache Spark on HDP"
