#!/bin/bash

sudo docker stop ingress
sudo docker rm ingress
mkdir -p $(pwd)/temp
sudo docker run  --name ingress -d --publish 80:80 --publish 443:443 --restart always --volume $(pwd)/temp:/usr/share/nginx/html nginx:alpine
