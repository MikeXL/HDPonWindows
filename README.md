# HDPonWindows


here is how it works

### 0. download hdp from hortonworks, easy

### 1. unpack the msi file
What? Yes, you hear me. As I had enough frustration to launch the msi over and over again, just doesn't work  

<code>msiexec /a hdp-x.x.x.x.msi /qn TARGETDIR=E:\\ </code>

*now take back your driver seat and steering wheel, easy*

### 2. Find the HadoopInstallFiles and unzip hadoop, hive
1. unzip hadoop.x.x.x.zip and place it to root folder, for instance, E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002  
2. unzip hive.x.x.x.x.zip and place it to root folder, for instance, E:\hdp-2.2.4.2\hive-0.14.0.2.2.4.2-0002  
3. unzip the rest if needed, such as tez and spark

### 3. Set environment variables
(path used as above sample)  
<code>
set HADOOP_HOME=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002  
SET HIVE_HOME=E:\hdp-2.2.4.2\hive-0.14.0.2.2.4.2-0002  
set HADOOP_PREFIX=E:\hdp-2.2.4.2\hadoop-2.6.0.2.2.4.2-0002  
set HADOOP_CONF_DIR=%HADOOP_HOME%\etc\hadoop  
set YARN_CONF_DIR=%HADOOP_CONF_DIR%  
set PATH=%PATH%;%HADOOP_HOME%\bin;%HIVE_HOME%/bin  
</code>

### 4. edit the xml configuration files 
I have it uploaded

### 5. format HDFS
<code>%HADOOP_HOME%\bin\hdfs namenode -format</code>

### 6. start hadoop
<code>%HADOOP_HOME%\sbin\start-dfs.cmd</code>

### 7. start yarn
<code>%HADOOP_HOME%\sbin\start-yarn.cmd</code>

then go to http://localhost:8088
yes.

### 8. start hive





[1]: https://wiki.apache.org/hadoop/Hadoop2OnWindows
