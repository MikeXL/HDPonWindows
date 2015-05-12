# Install HDP on Windows

Here is how it works on Windows 2012 R2 (technical preview).  Also tested on 2008 R2.
The idea is quite simple *xcopy* type of deployment.

This setup is for a single node *sandbox*, to setup a [multi-node cluster][7], please [click here][7] after below setups.


### 1. Prerequisites

* Python 2.7.6 x64 same as my Yosemite
* Java 1.8.0_45 x64
* Download hdp windows installer from Hortonworks
* Unpack the msi using _msiexec /a hdp-2.2.4.2.winpkg.msi /qn TARGETDIR=D:_

### 2. Find the D:\HadoopInstallFiles and unzip hadoop, hive, spark then put then in

    c:\hdp\hadoop
    c:\hdp\hive
    c:\hdp\spark


### 3. Set environment variables

    SET HADOOP_HOME=c:\hdp\hadoop
    SET HIVE_HOME=c:\hdp\hive
    SET SPARK_HOME=c:\hdp\spark
    SET HCAT_HOME=c:\hdp\hive\hcatalog
    SET HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoop
    SET YARN_CONF_DIR=%HADOOP_CONF_DIR%
    SET PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%\bin;%SPARK_HOME%\bin;%HCAT_HOME\bin
    REM
    REM In below I have prefix the full path so you would know where the file is,
    REM but no need when typing as above PATH setting
    REM ensure Python in PATH and JAVA_HOME is set too


    #
    # or if you may, run below PowerShell snippet to set user environment once for all
    #
    [Environment]::SetEnvironmentVariable("JAVA_HOME",        "C:\Java",                  "User")
    [Environment]::SetEnvironmentVariable("HADOOP_HOME",      "c:\hdp\hadoop",            "User")
    [Environment]::SetEnvironmentVariable("HIVE_HOME",        "c:\hdp\hive",              "User")
    [Environment]::SetEnvironmentVariable("SPARK_HOME",       "c:\hdp\spark",             "User")
    [Environment]::SetEnvironmentVariable("HCAT_HOME",        "c:\hdp\hive\hcatalog",     "User")
    [Environment]::SetEnvironmentVariable("HADOOP_CONF_DIR",  "c:\hdp\hadoop\etc\hadoop", "User")
    [Environment]::SetEnvironmentVariable("YARN_CONF_DIR",    "c:\hdp\hadoop\etc\hadoop", "User")
    [Environment]::SetEnvironmentVariable("PATH",             "c:\hdp\hadoop\bin;c:\hdp\hadoop\sbin;c:\hdp\hive\bin;c:\hdp\spark\bin;C:\Python;c:\Java\bin", "User")



### 4. edit the xml configuration files
I have it uploaded

### 5. format HDFS namenode
    %HADOOP_HOME%\bin\hdfs namenode -format

### 6. start hadoop dfs
    %HADOOP_HOME%\sbin\start-dfs.cmd

    _REM you may receive warning that above method will be deprecated, here is the new way_

    hdfs namenode
    hdfs datanode

### 7. start yarn
    %HADOOP_HOME%\sbin\start-yarn.cmd

    _REM you may receive warning that above method will be deprecated, here is the new way_

    yarn resourcemanager
    yarn nodemanager

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

1. Download SQL server JDBC (4.1 as of 25th April, 2015 with name sqljdbc41.jar) and place it to %HIVE_HOME%\lib  
2. In SQL azure, create a new database named HIVE, and record the host and login credential that needed in next step  
3. Checkout the hdp/hive/conf/hive-site.xml for configuration.  


### 10. start hive services

    %HIVE_HOME%\bin\hive --service hiveserver2  


### 11. Spark
It is as simple as placing [*yarn-client* or *yarn-cluster*][5] for the master parameter. And ensure the spark binary built with yarn support.  For instance, start pyspark.

    %SPARK_HOME%\bin\pyspark --master yarn-client


### 12. hcatalog
I have to say wow, hcat.py works with double quotation. maybe it is the nature of windows command line. I just so used to single.

    %HCAT_HOME%\bin\hcat.py -e "show tables"




[1]: https://wiki.apache.org/hadoop/Hadoop2OnWindows "Hadoop on Windows Wiki"
[2]: https://cwiki.apache.org/confluence/display/Hive/HiveDerbyServerMode#HiveDerbyServerMode-ConfigureHivetoUseNetworkDerby "Configure HIVE"
[3]: http://hortonworks.com/hadoop-tutorial/using-hive-data-analysis/ "Using Hive for Data Analysis"  
[4]: https://developer.ibm.com/hadoop/blog/2014/09/19/big-sql-3-0-file-formats-usage-performance/ "Good comparision of Hive storage format"  
[5]: http://blog.cloudera.com/blog/2014/05/apache-spark-resource-management-and-yarn-app-models/ "Spark yarn mode client vs master explained"  
[6]: http://hortonworks.com/hadoop-tutorial/using-apache-spark-hdp/ "Using Apache Spark on HDP"
[7]: https://github.com/MikeXL/HDPonWindows/blob/master/multi-node-cluster.md "multi node hadoop cluster"
