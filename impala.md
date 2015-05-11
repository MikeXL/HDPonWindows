# impala

## install bigtop-utils


    sudo wget -O /etc/yum.repos.d/bigtop.repo http://archive.apache.org/dist/bigtop/bigtop-0.6.0/repos/centos6/bigtop.repo
    sudo yum install bigtop-utils

## download impala rpms

    wget -r --no-parent http://archive.cloudera.com/impala/redhat/6/x86_64/impala/2/RPMS/x86_64/

## install from local

    sudo rpm -ivh impala-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-catalog-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-debuginfo-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-server-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-shell-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-state-store-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm
    sudo rpm -ivh impala-udf-devel-2.1.0-1.impala2.0.0.p0.15.el6.x86_64.rpm


## config

        
        sudo cp /etc/hadoop/conf/core-site.xml /etc/impala/conf
        sudo cp /etc/hadoop/conf/hdfs-site.xml /etc/impala/conf
        
        
## modify file /etc/init.d/impala-server line 35 to

        
        if [ -f /etc/default/hadoop] ; then
        . /etc/default/hadoop
        fi
  

## start services

    sudo service impala-state-store start
    sudo service impala-catalog start
    sudo service impala-server start

## open port
21000 service
25000 impala web ui
25010 state store web ui
25020 catalog web ui
