#!/bin/bash -e
yum install nginx -y
service nginx start
systemctl stop firewalld.service