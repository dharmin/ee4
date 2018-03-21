#!/bin/bash
EE_HOME=${HOST_HOME}
U_ID=${USER_ID}
G_ID=${GROUP_ID}
D_ID=${DOCKER_ID}

groupadd -r -g $D_ID docker
groupadd -r -g $G_ID ee
useradd -r -d $EE_HOME -u $U_ID -g ee ee
addgroup ee docker

chown -R ee:ee $EE_HOME
mkdir -p $EE_HOME/.ee4 $EE_HOME/Sites
chown -R ee:ee $EE_HOME

cat > /tmp/entrypoint.sh << EOF
#!/bin/sh
tail -f /dev/null
EOF