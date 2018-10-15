FROM debian:jessie
# Use jessie for Apache2.4 . Whith weezy : Apache2.2
LABEL Description="This image is for building JIRA"

MAINTAINER Team Lucien Kabuku <lucien.kabuku@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

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
COPY /load/dbconfig.xml /opt/downloads/dbconfig.

RUN mkdir /var/www/html/jira/config
COPY /load/check_connection.php /var/www/html/jira/config/check_connection.php

# To prevent caching when rebuilding the image,
# the update and install command must be in the same RUN.
# See https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run

### Install Apache2 and PHP ###

RUN apt-get -t stable update && \
    apt-get install -y apache2

RUN apt-get install -y git php5 libapache2-mod-php5 php5-mcrypt php5-mysql

### Configuration Apache ###

RUN echo "deb http://http.us.debian.org/debian sid main non-free contrib" >> /etc/apt/sources.list.d/dotdeb.org.list
RUN apt-get update

COPY /load/apache2.conf /etc/apache2/apache2.conf
COPY /load/ports.conf /etc/apache2/ports.conf
COPY /load/vhosts.conf /etc/apache2/sites-available/vhosts.conf
RUN a2ensite vhosts.conf


### Configuration Apache ###

RUN a2enmod ssl rewrite headers expires proxy proxy_http deflate
ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2
ENV LANG               C

### Remove default VirtualHost ###

RUN rm -rf /etc/apache2/sites-enabled/000-default.conf

### Install utils ###

RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    vim  \
    git \
    zsh \
    htop \
    nmon \
    sysstat \
    locales \
    wget \
    w3m \
    net-tools \
    iputils-ping \
    nfs4-acl-tools \
    unzip \
    zip \
    tar \
    locales \
    iptables \
    openssl \
    gettext \
    nscd \
    mysql-server

# nscd : caching of DNS request

# Clean apt repository
#RUN apt-get clean && apt-get autoclean && apt-get autoremove


### Install Java ###
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y && apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default

EXPOSE 80 443 8080 8088

CMD rm -f "$APACHE_PID_FILE" && /usr/sbin/apache2ctl -D FOREGROUND