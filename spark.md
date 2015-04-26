


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
        --hiveconf hive.server2.thrift.port=20000
