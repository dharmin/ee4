#!/bin/bash

# Check docker
if ! which docker > /dev/null 2>&1; then
    echo "Installing docker"
    wget get.docker.com -O docker-setup.sh
    if ! sh docker-setup.sh > /dev/null 2>&1; then
        if sudo usermod -aG docker $USER > /dev/null 2>&1; then
            rm docker-setup.sh
        else
            echo "Please logout and login again to complete the docker setup"
        fi
    else
        echo "Docker installation failed"
    fi
fi