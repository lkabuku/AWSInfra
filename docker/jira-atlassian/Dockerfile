FROM 846572358120.dkr.ecr.eu-west-1.amazonaws.com/skopiteam:core
MAINTAINER Team Lucien Kabuku <lucien.kabuku@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
LABEL Description="This image is for building JIRA"

#Export variables proxy
RUN export HTTP_PROXY
RUN export HTTPS_PROXY
RUN export http_proxy
RUN export https_proxy

### WEB DIRECTORIES ###

RUN mkdir -p /var/www/html/jira

### DOWNLOADS DIRECTORIES ###

RUN mkdir -p /opt/downloads

### ATLASSIAN JIRA SOFTWARE ###

COPY /load/atlassian-jira-software-7.9.1-x64.bin /opt/downloads/atlassian-jira-software-7.9.1-x64.bin
RUN chown www-data:www-data /opt/downloads/atlassian-jira-software-7.9.1-x64.bin
RUN chmod a+x /opt/downloads/atlassian-jira-software-7.9.1-x64.bin

### MYSQL CONNECTOR JAVA 5.1 ###

COPY /load/mysql-connector-java-5.1.46-bin.jar /opt/downloads/mysql-connector-java-5.1.46-bin.jar
RUN chown www-data:www-data /opt/downloads/mysql-connector-java-5.1.46-bin.jar

COPY /load/mysql-connector-java-5.1.46.jar /opt/downloads/mysql-connector-java-5.1.46.jar
RUN chown www-data:www-data /opt/downloads/mysql-connector-java-5.1.46.jar

### ADD FILES

COPY /load/credentials_DB /opt/downloads/credentials_DB
COPY /load/dbconfig.xml /opt/downloads/dbconfig.xml

RUN mkdir /var/www/html/jira/config
COPY /load/check_connection.php /var/www/html/jira/config/check_connection.php

### Configuration Apache ###

COPY /load/apache2.conf /etc/apache2/apache2.conf
COPY /load/ports.conf /etc/apache2/ports.conf
COPY /load/vhosts.conf /etc/apache2/sites-available/vhosts.conf
RUN a2ensite vhosts.conf

EXPOSE 80 443 8080 8088

CMD rm -f "$APACHE_PID_FILE" && /usr/sbin/apache2ctl -D FOREGROUND