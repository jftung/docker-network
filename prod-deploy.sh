#!/bin/bash

git pull
echo $CR_PAT | sudo docker login ghcr.io -u jftung --password-stdin
sudo docker pull ghcr.io/jftung/nginx-reverse-proxy
sudo docker pull ghcr.io/jftung/certbot-beale
sudo docker pull ghcr.io/jftung/nginx-beale
sudo docker pull ghcr.io/jftung/jenkins-host
