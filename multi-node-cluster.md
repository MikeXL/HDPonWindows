# HDP Cluster


    *unicorn* <- head node aka name node
    +=========================+
    |   yarn node manager     |
    |   yarn resource manager |
    |   hdfs name node        |
    |   hdfs data node        |
    +=========================+


    *pony* <- data node aka workder node       *foal* <- data node aka workder node

    +=========================+               +=========================+
    |   yarn node manager     |               |   yarn node manager     |
    |   hdfs data node        |               |   hdfs data node        |
    +=========================+               +=========================+


## 1. name node or head node

 *same setup as the single node sandbox with below*
 add the datanode or compute node hostname or ip address to files *slaves* and *yarn.include*
 for instance, I have two data nodes named _pony_ and _foal_

### %hadoop_conf_dir%\slaves

    > cat %HADOOP_CONF_DIR%\slaves
      localhost
      pony
      foal


### %hadoop_conf_dir%\yarn.include

    > cat %HADOOP_CONF_DIR%\yarn.include
      pony
      foal


## 2. data node or compute node
  Please refer to the [datanode][1] folder for the configuration files.  
  (replace %NAMENODE% with ip address of your namenode (or headnode or master) or set environment variable, latter is not tested)


    REM set namenode server
    SET NAMENODE=unicorn

    REM start data node
    hdfs datanode

    REM start yarn node manager
    yarn nodemanager

## 3. change the replication factor to 3 if desired

    dfs.replication = 3 in hdfs-site.xml


## 4. useful commands

    REM to list all nodes
    hdfs dfsadmin -report

    REM to refresh nodes
    hdfs dfsadmin -refreshNodes



[1]: https://github.com/MikeXL/HDPonWindows/tree/master/datanode/hdp/hadoop/etc "data node configuration files"
