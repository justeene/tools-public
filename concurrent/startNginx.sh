#!/bin/bash -e
sudo echo "
root soft core 10240000
root hard core 10240000" >>/etc/security/limits.conf
ulimit -n 10240000
yum install nginx -y
service nginx start
systemctl stop firewalld.service