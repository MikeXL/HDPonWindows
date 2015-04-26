

REM **************************************************
REM         pyspark interaction on yarn              *
REM                                                  *
REM **************************************************

REM start pyspark .. however it still not read in the right hive ?... ?
pyspark ^
  --master yarn-client ^
  --jars %hive_home%/lib/sqljdbc41.jar ^
  --files %hive_home%/conf/hive-site.xml

REM from pyspark.sql import HiveContext
REM sqlContext = HiveContext(sc)
REM sqlContext.sql("show databases").collect()
REM sqlContext.sql("show tables").collect()

REM sqlContext.sql("CREATE TABLE IF NOT EXISTS src (key INT, value STRING)")
REM sqlContext.sql("LOAD DATA LOCAL INPATH 'c:/hdp/spark/examples/src/resources/kv1.txt' INTO TABLE src")
REM results = sqlContext.sql("FROM src SELECT key, value").collect()

REM **************************************************
REM         submit spark job on yarn                 *
REM                                                  *
REM **************************************************

REM submit job to cluster
spark-submit ^
  --verbose ^
  --class org.apache.spark.examples.SparkPi ^
  --master yarn-cluster ^
  --num-executors 3 ^
  --driver-memory 512m ^
  --executor-memory 512m ^
  --executor-cores 1 ^
  %spark_home%/lib/spark-examples*.jar 10


REM **************************************************
REM         thrift hive server 2                     *
REM                                                  *
REM **************************************************


REM start the spark sql hive server
spark-submit.cmd ^
  --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 ^
    spark-internal \
  --hiveconf hive.server2.thrift.port=20000 \
  --hiveconf hive.server2.thrift.host=host
  --hiveconf hive.metastore.uris=http://localhost:9983

REM  default Thrift port is 9083. For Hortonworks 2 installations, it is 9983
