#!/bin/bash -e
yum install iperf3 -y
systemctl stop firewalld.service
iperf3 -s -p 8443