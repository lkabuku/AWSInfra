# Jira Setup

[https://confluence.atlassian.com/adminjiraserver/installing-jira-applications-on-linux-938846841.html](https://confluence.atlassian.com/adminjiraserver/installing-jira-applications-on-linux-938846841.html))

### Install Jira
```
sudo /opt/downloads/./atlassian-jira-software-7.9.1-x64.bin
```
Jira path : default
Install type => 2
Ports: 8080 and 8088

### Configure connector driver for mysql
```
sudo mv /opt/downloads/mysql-connector-java-5.1.46.jar /opt/atlassian/jira/lib/mysql-connector-java-5.1.46.jar
sudo mv /opt/downloads/mysql-connector-java-5.1.46-bin.jar /opt/atlassian/jira/lib/mysql-connector-java-5.1.46-bin.jar
export CLASSPATH=/opt/atlassian/jira/lib/mysql-connector-java-5.1.46.jar:$CLASSPATH
```

### Configure credentials for jira database
```
sudo mv /opt/downloads/dbconfig.xml /var/atlassian/application-data/jira/dbconfig.xml
sudo sh /opt/atlassian/jira/bin/config.sh
```

### Lanuch jira
```
sudo sh /opt/atlassian/jira/bin/startup.sh
```
