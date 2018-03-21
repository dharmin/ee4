#!/bin/sh

EE_HOME=$HOME

mkdir $EE_HOME/.ee4 $EE_HOME/Sites
touch $EE_HOME/.ee4/ee4_hosts
echo "addn-hosts=/etc/ee4_hosts" > ~/.ee4/dnsmasq.conf

USER_ID=`id -u`
GROUP_ID=`id -g`
DOCKER_ID=`getent group docker | cut -d: -f3`

docker run  --net=host -v ~/.ee4:$EE_HOME/.ee4 -v ~/Sites:$EE_HOME/Sites \
			-v /var/run/docker.sock:/var/run/docker.sock:ro \
			-e HOST_HOME=$EE_HOME -e USER_ID=$USER_ID -e GROUP_ID=$GROUP_ID -e  DOCKER_ID=$DOCKER_ID \
			dharmin/base2

docker run --name dnsmasq -d \
    -p 127.0.0.1:53:53/udp \
    -v $EE_HOME/.ee4/dnsmasq.conf:/etc/dnsmasq.d/dnsmasq.conf \
	-v $EE_HOME/.ee4/ee4_hosts:/etc/ee4_hosts \
    --restart always \
    dharmin/dnsmasq