#!/bin/sh
EE_HOME=${HOST_HOME}

U_ID=${USER_ID}
G_ID=${GROUP_ID}
D_ID=${DOCKER_ID}

groupadd -r -g $D_ID docker
groupadd -r -g $G_ID ee && useradd -r -d $EE_HOME -u $U_ID -g ee ee
addgroup ee docker

gosu ee /usr/local/bin/ee4 --debug $@
/bin/bash