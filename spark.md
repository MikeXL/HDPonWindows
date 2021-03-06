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


### Interesting Stuff

If you notice that the spark jobs are executed on a single node in a cluster environment, there is a [fairly good explanation][1] for it.


### SparkR

Well, it is exciting, but sorta waiting for the binary version of it. Not keen into build it myself.
[Click here][2] to download the latest 1.4 nightly build, be aware of the errors, and use on your own risk.


    ### the code is directly from apache spark github reading
    ### in RStudio

    ### set the environment variables for yarn
    Sys.setenv(SPARK_HOME = '/opt/spark')
    Sys.setenv(HADOOP_CONF_DIR = '/etc/hadoop/conf')
    Sys.setenv(YARN_CONF_DIR = '/etc/hadoop/conf')

    ### setup and load the sparkr lib
    ### you can make it more dynamic by using $SPARK_HOME
    ###
    .libPaths(c("/opt/spark/R/lib", .libPaths()))
    library(sparkR)

    ### start in yarn-client mode
    ### ! on hdp, ensure the hdp version is set in
    ### !        $SPARK_HOME/conf/spark-defaults.conf
    ###
    ### sc <- sparkR.init(master="yarn-client")  
    sc <- sparkR.init("yarn-client") 

    ### or else start in standalone
    sc <- sparkR.init()  

    ### get sqlContext, I just been lazy sqlctx
    sqlctx <- sparkRSQL.init(sc)  

    ### prior to loading the file, copy 'em from local to hdfs
    ### hdfs dfs -copyFromLocal $SPARK_HOME/examples/src/main/resources/* /user/spock
    ###
    path = '/user/spock/people.json'
    peopleDF <- jsonFile(sqlctx, path)
    printSchema(peopleDF)


    ### register temp table and experience the sql query
    registerTempTable(peopleDF, "people")
    teenagers <- sql(sqlctx, "SELECT name FROM people WHERE age >= 13 AND age <= 19")
    teenagersLocalDF <- collect(teenagers)

    dim(teenagersLocalDF)
    names(teenagersLocalDF)
    head(teenagersLocalDF)



[1]: https://issues.apache.org/jira/browse/SPARK-4360 "only run on single node in a cluster"
[2]: http://people.apache.org/~pwendell/spark-nightly/ "spark nightly build"
