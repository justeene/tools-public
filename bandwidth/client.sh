#!/bin/bash -e
yum install iperf3 -y
iperf3 -c serverIp -p 8443