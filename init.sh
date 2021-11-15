#!/bin/bash
setenforce 0 && \
getenforce && \
yum install -y -q \
    epel-release && \
yum update -y -q && \
yum install -y -q    wget      ncdu      tree      vnstat      htop      unzip      curl      git &&\
curl -fsSL https://get.docker.com -o get-docker.sh && \
      sh get-docker.sh &&\
curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose &&\
timedatectl set-timezone Asia/Tokyo&&\
systemctl start docker && \
systemctl enable docker &&\
firewall-cmd --permanent --zone=public --add-port=2233/tcp &&\
firewall-cmd --reload
