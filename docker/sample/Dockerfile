FROM debian:jessie
# Use jessie for Apache2.4 . Whith weezy : Apache2.2
LABEL Description="This image is a base for differents web projects"

MAINTAINER Team Skopitone <skopiteam@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

#Export variables proxy
RUN export HTTP_PROXY
RUN export HTTPS_PROXY
RUN export http_proxy
RUN export https_proxy

### WEB DIRECTORIES ###

RUN mkdir -p /var/www/html/skopitone

### ADD index.html ###

COPY load/index.html /var/www/html/skopitone/index.html

# To prevent caching when rebuilding the image,
# the update and install command must be in the same RUN.
# See https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run

#APACHE 2

RUN apt-get -t stable update && \
    apt-get install -y apache2

RUN apt-get install -y git php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Configuration apache
# Add the SID repo to enable mod_auth_mellon. Will result to an upgrade of apache
# Auth config is in vhost_mx.conf and in mod_auth_mellon/
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

### UTILS ###

# Install

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
    locales \
    iptables \
    openssl \
    gettext \
    nscd
# nscd : caching of DNS request

EXPOSE 80 443

CMD rm -f "$APACHE_PID_FILE" && /usr/sbin/apache2ctl -D FOREGROUND