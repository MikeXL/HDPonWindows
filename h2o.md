H2O
============

## Run in a multi-node cluster
Download H2O and put into /opt/h2o for every single node. Then assume you wanna start 3 nodes with 2GB memory:

    hadoop jar h2odriver.jar -nodes 3 -mapperXmx 2g -output hdfsWater &
