#!/bin/bash


if ! which ee4 > /dev/null; then
    if [ "$(uname -s | tr '[:upper:]' '[:lower:]')" = "linuxs" ];then
        # Checking docker
        if ! which docker > /dev/null 2>&1; then
            echo "Installing docker"
            wget get.docker.com -O docker-setup.sh
            if ! sh docker-setup.sh > /dev/null 2>&1; then
                if sudo usermod -aG docker $USER > /dev/null 2>&1; then
                    if su - $USER; then
                        rm docker-setup.sh
                        exit
                    fi
                else
                    echo "Please logout and login again to complete the docker setup"
                fi
            else
                echo "Docker installation failed"
            fi
        fi
    else
        echo "Docker is required to use EasyEngine v4."
        exit
    fi
    # Installing ee4
    wget https://raw.githubusercontent.com/dharmin/ee4/master/ee -O ee4
    chmod +x ee4
    sudo mv ee4 /usr/local/bin/ee4
fi
