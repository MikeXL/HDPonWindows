# HDP Cluster

## 1. name node or head node

 *same setup as the single node sandbox with below*
 add the datanode or compute node hostname or ip address to files *slaves* and *yarn.include*
 for instance, I have two data nodes named _data_ and _computer_

### 1.1 %hadoop_conf_dir%\slaves

    > cat %HADOOP_CONF_DIR%\slaves
      localhost
      data
      computer


### 1.2 %hadoop_conf_dir%\yarn.include

    > cat %HADOOP_CONF_DIR%\yarn.include
      data
      computer


## 2. data node or compute node
  add reference to name node in files, please refer to datanode folder.
  (replace %HEADNODE% with ip address of your headnode or set environment variable, latter is not tested)

  - core-site.xml
  - hdfs-site.xml
  - mapred-site.xml
  - yarn-site.xml


    REM start data node
    hdfs datanode
    
    REM start yarn node manager
    yarn nodemanager

## 3. useful commands

    REM to list all nodes
    hdfs dfsadmin -report

    REM to refresh nodes
    hdfs dfsadmin -refreshNodes
