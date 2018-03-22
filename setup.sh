#!/bin/sh


mkdir ~/Sites ~/.ee4 > /dev/null 2>&1
touch ~/.ee4/ee4_hosts > /dev/null 2>&1

EE_HOME=$HOME

mkdir $EE_HOME/.ee4 $EE_HOME/Sites > /dev/null 2>&1
touch $EE_HOME/.ee4/ee4_hosts > /dev/null 2>&1

USER_ID=`id -u`
GROUP_ID=`id -g`
DOCKER_ID=`getent group docker | cut -d: -f3`

docker run --name dnsmasq -d -p 127.0.0.1:53:53/udp  -v $EE_HOME/.ee4/ee4_hosts:/etc/ee4_hosts --restart always dharmin/dnsmasq-ee > /dev/null 2>&1