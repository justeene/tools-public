#!/bin/bash -e
#test
echo "
vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time=120
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.all.arp_announce=2
net.ipv4.tcp_max_tw_buckets = 100
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_max_syn_backlog = 3240000
net.ipv4.tcp_window_scaling = 1
#net.ipv4.tcp_keepalive_time = 60
net.ipv4.tcp_synack_retries = 2
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv4.conf.lo.arp_announce=2
fs.file-max = 40000500
fs.nr_open = 40000500
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_keepalive_time = 1
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_keepalive_probes = 3

net.ipv4.tcp_fin_timeout = 5
net.ipv4.tcp_mem = 768432 2097152 15242880
net.ipv4.tcp_rmem = 4096 4096 33554432
net.ipv4.tcp_wmem = 4096 4096 33554432
net.core.somaxconn = 6553600
net.ipv4.ip_local_port_range = 2048 64500
net.core.wmem_default = 183888608
net.core.rmem_default = 183888608
net.core.rmem_max = 33554432
net.core.wmem_max = 33554432
net.core.netdev_max_backlog = 2621244
kernel.sem=250 65536 100 2048
kernel.shmmni = 655360
kernel.shmmax = 34359738368
kerntl.shmall = 4194304
kernel.msgmni = 65535
kernel.msgmax = 65536
kernel.msgmnb = 65536

net.netfilter.nf_conntrack_max=1000000
net.nf_conntrack_max=1000000
net.ipv4.netfilter.ip_conntrack_max=1000000
kernel.perf_cpu_time_max_percent=60
kernel.perf_event_max_sample_rate=6250

net.ipv4.tcp_max_orphans=1048576
kernel.sched_migration_cost_ns=5000000
net.core.optmem_max = 25165824

kernel.sem=10000 2560000 10000 256
" >> /etc/sysctl.conf
echo "
root soft core 4096000
root hard core 4096000
root soft nofile 4096000
root hard nofile 4096000
" >>/etc/security/limits.conf
ulimit -n 1024000
yum install git unzip -y
git clone https://github.com/wg/wrk.git
yum group install "Development Tools" -y
cd wrk  
make
host="127.0.0.1:80"
#只要带宽够，本机和公网无太大区别
#88thread 20seconds keep 10000 connections open
#1vcpu=7w  4vcpu=22w 8vcpu=35w
./wrk -t88 -c10000 -d30s "http://${host}/a.html"
#1vcpu=42w(纯) 4vcpu=39w 8vcpu=62w
./wrk -t300 -c50000 -d30s "http://${host}/a.html"
#1vcpu=13w 4vcpu=56w 8vcpu=104w
./wrk -t500 -c100000 -d30s "http://${host}/a.html"