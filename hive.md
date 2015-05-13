# Hive



### metastore (on SQL Azure)



### HCatalog


### storage format
[Here][4] is the good comparison and benchmark done by IBM.


### execution engine

* mr
* tez
* spark


### local mode

    SET HIVE_OPTS='-hiveconf mapred.job.tracker=local \
                   -hiveconf fs.default.name=file:///tmp \
                   -hiveconf hive.metastore.warehouse.dir=file:///tmp/warehouse \
                   -hiveconf javax.jdo.option.ConnectionURL=jdbc:derby:;databaseName=/tmp/metastore_db;create=true'
   %HIVE_HOME%\bin\hive




[4]: https://developer.ibm.com/hadoop/blog/2014/09/19/big-sql-3-0-file-formats-usage-performance/ "Good comparision of Hive storage format"  
