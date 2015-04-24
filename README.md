# HDP on Windows


Here is how it works on either Windows 2008 R2 or Windows 10 (server technical preview).  

### 0. download hdp from hortonworks, easy
Prerequisites still required, such as  

- Python (I've got 2.7.6 x64 to keep consistent with other computers, such as my Mac)  
- Java (I went a bit far, got 1.8.0_45)  
- Viscual C++ 2010 SP1 Redistributable x64  
- PowerShell 3.0 if you are on windows 2008 R2; not needed if you are on Windows 10 (oh yes, it comes with PS 5.0)  

### 1. unpack the msi file
What? Yes, you hear me. As I had enough frustration to launch the msi over and over again, just doesn't work  

    msiexec /a hdp-x.x.x.x.msi /qn TARGETDIR=E:\\

*now take back your driver seat and steering wheel, easy*

### 2. Find the HadoopInstallFiles and unzip hadoop, hive
1. unzip hadoop.x.x.x.zip and place it to root folder, for instance, E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002  
2. unzip hive.x.x.x.x.zip and place it to root folder, for instance, E:\hdp-2.2.4.2\hive-0.14.0.2.2.4.2-0002  
3. unzip the rest if needed, such as tez and spark

### 3. Set environment variables
(path used as above sample, other than below, ensure python in the PATH and JAVA_HOME is set.)  

    SET HADOOP_HOME=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002
    SET HIVE_HOME=E:\hdp-2.2.4.2\hive-0.14.0.2.2.4.2-0002
    SET HADOOP_PREFIX=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002
    SET HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoop
    SET YARN_CONF_DIR=%HADOOP_CONF_DIR%
    SET PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%\bin


or run env.cmd (uploaded in the hdp folder inside this repo).

### 4. edit the xml configuration files
I have it uploaded

### 5. format HDFS
    %HADOOP_HOME%\bin\hdfs namenode -format

### 6. start hadoop
    %HADOOP_HOME%\sbin\start-dfs.cmd

### 7. start yarn
    %HADOOP_HOME%\sbin\start-yarn.cmd

then fire up your browser, again, in my case http://unicorn:8088  
yes.

### 8. create hive data warehouse structure (folders)

    %HADOOP_HOME%/bin/hadoop fs -mkdir       /tmp
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user/hive
    %HADOOP_HOME%/bin/hadoop fs -mkdir       /user/hive/warehouse
    %HADOOP_HOME%/bin/hadoop fs -chmod g+w   /tmp
    %HADOOP_HOME%/bin/hadoop fs -chmod g+w   /user/hive/warehouse


### 9. configure hive (optional: as I like to use SQL server for meta store, in my case SQL Azure)

1. Download SQL server JDBC and place it to %HIVE_HOME%\lib  
2. In SQL server, create a new database for HIVE, I have it named as HIVE owned by a user hive with password Hadoop1234  
3. Checkout the hive-site.xml configuration file in the hdp/hive/conf folder in this repo for setup  


### 10. start hive services
Thought it is very complicated, and following thru the scripts hortonworks made. Then, it is a very simple way:

    %HIVE_HOME%\bin\hive --service hiveserver2  


### 11. connect to hive
  Connect via hive client on the same box, simply type in *hive*  
  Connect via ODBC, just remember to punch in the username hive and password setup for the metastore


### 12. Spark
It is as simple as this to run spark on yarn interactively if you have the spark binary built with yarn support.  

    pyspark --master *yarn-client*

use yarn-master when submitting an spark app.  for instance,

  %spark_home%\bin\spark-submit.cmd --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --master yarn-custer spark-internal


### 13. hive on tez vs hive on spark


### 14. hive file format orc vs parquet



### 15. hcatalog
I have to say wow, hcat.py works with double quotation. maybe it is the nature of windows command line. I just so used to single.

  %HCAT_HOME%\bin\hcat.py -e "desc mtcars"





Last but not least thanks to  
1. [Hadoop on Windows wiki page][1]  
2. [Hive wiki page to setup metastore][2]
3. [Using Hive for Data Analysis][3] - a very quickstart type to use hive  


[1]: https://wiki.apache.org/hadoop/Hadoop2OnWindows "Hadoop on Windows Wiki"
[2]: https://cwiki.apache.org/confluence/display/Hive/HiveDerbyServerMode#HiveDerbyServerMode-ConfigureHivetoUseNetworkDerby "Configure HIVE"
[3]: http://hortonworks.com/hadoop-tutorial/using-hive-data-analysis/ "Using Hive for Data Analysis"
[4]: https://developer.ibm.com/hadoop/blog/2014/09/19/big-sql-3-0-file-formats-usage-performance/ "Good comparision of Hive storage format"
