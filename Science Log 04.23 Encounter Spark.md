🖖

Data Science Log 1504.23 - embark journey on evaluating spark (again).

Yes, it is like paying another visit after seeing their 2015 vision and roadmap. It worth more effort, here is why:

1. Data Science workflow, tighter integration with R coming this summer (June), *DataFrame* is sort of a preview
2. ODBC / JDBC support that enable a lot possibilities, *tableau*, everyone. Spark SQL ODBC is actually just HIVE ODBC. It appears Simba just rename it to hortonworks, cloudera, mapr or spark, whatever the name needed. It is the same protocol. But may have different restriction on SQL syntax as they do not support the same set of standard. HIVE might be superior for now, but they all run simple query.
3. MLLib, I gotta start somewhere to get deeper on machine learning

As IT have provided an Linux system that comes with Python 2.6.6 and JRE 1.7.0, it meets the spark requirements. All needed is to download the pre-built package, then unzip it (tar zxvf if you may).
bin/start-all.sh
bin/start-thriftserver.sh

PS install the hortonworks ODBC on Mac
I’m not fan of putting drivers into /usr/lib than /opt, so I unpack the hortonworks ODBC and then put it into /opt/hortonworks, manually copy over odbcinst.ini into ~/.odbcinst.ini and hortonworks.odbc.ini to ~/.hortonworks.odbc.ini and modify the path accordingly
One caution, need to create sym link in /usr/lib to make sure tableau working, as tableau may just have hardcoded it for each vendor.


LLAP
