# spark


### pyspark HiveContext code


    from pyspark.sql import HiveContext
    sqlContext = HiveContext(sc)
    sqlContext.sql("show databases").collect()
    sqlContext.sql("show tables").collect()

    sqlContext.sql("CREATE TABLE IF NOT EXISTS src (key INT, value STRING)")
    sqlContext.sql("LOAD DATA LOCAL INPATH 'c:/hdp/spark/examples/src/resources/kv1.txt' INTO TABLE src")
    results = sqlContext.sql("FROM src SELECT key, value").collect()


### submit pi example to yarn cluster

    %SPARK_HOME%\bin\spark-submit --verbose ^
      --class org.apache.spark.examples.SparkPi ^
      --master yarn-cluster ^
      --num-executors 3 ^
      --driver-memory 512m ^
      --executor-memory 512m ^
      --executor-cores 1 ^
      %spark_home%/lib/spark-examples*.jar 10  


### start spark SQL thrift server with remote metastore on SQL Azure like hive does

    REM
    REM Copy %HIVE_HOME%\conf\hive-site.xml to %SPARK_HOME%\conf\
    REM

    SET SPARK_CLASSPATH=%HIVE_HOME%\lib\sqljdbc41.jar

    %SPARK_HOME%\bin\spark-submit --verbose ^
        --master yarn-client ^
        --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 ^
        spark-internal ^
        --hiveconf hive.server2.thrift.port=20000 ^


kinda need this for my linux box for standalone mode as default is user/hive/warehouse

    $SPARK_HOME/bin/spark-submit \
      --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 \
      spark-internal \
      --hiveconf hive.server2.thrift.port=10000 \
      --hiveconf hive.metastore.warehouse.dir=/home/mike/hive/warehouse &

### Execute Spark SQL via RODBC - create tables from json, parquet and jdbc (SQL Server)

      sqlQuery(ch, 'CREATE TABLE users
                    USING org.apache.spark.sql.parquet
                    OPTIONS (
                        path "/home/mike/spark/examples/src/main/resources/users.parquet"
                    )'
               );


      sqlQuery(ch, 'CREATE TABLE parquetTable
                    USING org.apache.spark.sql.parquet
                    OPTIONS (
                        path "/home/mike/spark/examples/src/main/resources/users.parquet"
                    )'
               );

      sqlQuery(ch, 'CREATE TABLE jdbcTable
                    USING org.apache.spark.sql.jdbc
                    OPTIONS (
                        url "jdbc:sqlserver://pony;databaseName=HIVE;user=hive;password=hive",
                        dbtable "TBLS"
                    )'
              );
