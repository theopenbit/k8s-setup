#!/bin/bash
if [ -z $1 ]; then
    echo 'usage startup.sh <pathToYourKubeConfig>'
    exit 1
fi
hash curl &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "curl not found. please install it..."
    exit 1 
fi

hash docker-compose &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "docker-compose not found. installing it..."
    curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

export KUBECONFIG=$1
export KUBECONFIG_PATH=$(dirname $KUBECONFIG)
sudo -E docker-compose up -d
