#!/bin/sh
EE_HOME=${HOST_HOME}
U_ID=${USER_ID}
G_ID=${GROUP_ID}
D_ID=${DOCKER_ID}

groupadd -g $D_ID docker
useradd -u $U_ID ee
groupmod -g $G_ID ee
usermod -d $EE_HOME -u $U_ID ee
addgroup ee docker

gosu ee /usr/local/bin/ee4 ${ARGS}