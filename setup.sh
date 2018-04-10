#!/bin/bash

function install_ee4{
    # Install ee4
    wget https://raw.githubusercontent.com/dharmin/ee4/master/ee -O ee
    chmod +x ee
    sudo mv ee /usr/local/bin/ee
}

# Check OS
if [ "$(uname -s | tr '[:upper:]' '[:lower:]')" = "linux" ]; then
    echo "EasyEngine v4 is currently in beta. Do you still want to install ? [y/n] : "
    read ee4

    if [ "$ee4" = "y" -o "$ee4" = 'Y' ]; then
        source setup_docker.sh
        if ! sudo ee -v | grep "v3" > /dev/null; then
            echo "EasyEngine v3 found on the system!  We have to disable EasyEngine v3 and all of its stacks permanently to setup EasyEngine v4.  Do you want to continue ? [y/n] : "
            read ee3
            if [ "$ee3" = "y" -o "$ee3" = 'Y' ]; then
                install_ee4
                echo "Do you want to migrate the sites ? ( Some sites may not work as you expected. ) [y/n] : "
                source migrate.sh
            fi
        else
            install_ee4
        fi
    fi
else
    # MacOS
    source install_mac.sh
fi