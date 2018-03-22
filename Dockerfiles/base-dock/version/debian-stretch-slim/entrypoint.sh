#!/bin/bash
EE_HOME=${HOST_HOME}
U_ID=${USER_ID}
G_ID=${GROUP_ID}
D_ID=${DOCKER_ID}

groupadd -r -g $D_ID docker
groupadd -r -g $G_ID ee
useradd -r -d $EE_HOME -u $U_ID -g ee ee
addgroup ee docker

# mkdir -p $EE_HOME/.ee4 $EE_HOME/Sites
# chown -R ee:ee $EE_HOME

CMND="$@"

docker run --net=host -t --rm --dns 172.17.0.2 -e ARGS="$CMND" -e HOST_HOME=$HOST_HOME -e USER_ID=$USER_ID -e GROUP_ID=$GROUP_ID -e  DOCKER_ID=$DOCKER_ID -v /var/run/docker.sock:/var/run/docker.sock -v $HOST_HOME/.ee4:$HOST_HOME/.ee4 -v $HOST_HOME/Sites:$HOST_HOME/Sites  dharmin/ee4
# cat > /tmp/entrypoint.sh << EOF
# #!/bin/sh
# tail -f /dev/null
# EOF