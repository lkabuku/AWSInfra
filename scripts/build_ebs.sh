#!/usr/bin/env bash

# PATHS
DIR_AWS=/var/www/html/infra/AWSInfra

DIR_AWS_DOCKER=$DIR_AWS/docker
DIR_AWS_BUILD=$DIR_AWS/build

DIR_AWS_DOCKER_JIRA=$DIR_AWS_DOCKER/jira
DIR_AWS_DOCKER_SAMPLE=$DIR_AWS_DOCKER/sample


### CLEAN BUILD DIRECTORY ###

rm -rf $DIR_AWS_BUILD/*


### BUILD EBS PACKAGE JIRA ###

echo :::::::::::::::: $(date) ::::::::::::::::
echo :::::::::::::::: BUILD ZIP FILES IN $DIR_AWS_DOCKER_JIRA ::::::::::::::::
echo "\r\n";

cd "$DIR_AWS_DOCKER_JIRA"
mkdir $DIR_AWS_BUILD/jira

zip $DIR_AWS_BUILD/jira/ebs_jira.zip Dockerfile load/* Dockerrun.aws.json

last_res=$?
if [ $last_res != 0 ]; then
	echo >&2 "!! build ebs_jira.zip failed with error $last_res"
	exit $last_res
fi

echo "\r\n";
echo "BUILD JIRA successfully"
echo "\r\n\r\n";


### BUILD EBS PACKAGE SAMPLE ###

echo :::::::::::::::: $(date) ::::::::::::::::
echo :::::::::::::::: BUILD ZIP FILES IN $DIR_AWS_DOCKER_SAMPLE ::::::::::::::::
echo "\r\n";

cd "$DIR_AWS_DOCKER_SAMPLE"
mkdir $DIR_AWS_BUILD/sample

zip $DIR_AWS_BUILD/sample/ebs_sample.zip Dockerfile load/* Dockerrun.aws.json

last_res=$?
if [ $last_res != 0 ]; then
	echo >&2 "!! build ebs_sample.zip failed with error $last_res"
	exit $last_res
fi

echo "\r\n";
echo "BUILD SAMPLE successfully"
echo "\r\n";

### CHANGE RIGHTS FOR ALL FILES IN DIRECTORY /build ###

chmod -R 777 $DIR_AWS_BUILD/*

exit 0