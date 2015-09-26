#!/bin/sh
#
# server initial setup script
#

apt update
apt install sysstat htop strace percona-toolkit tcpdump

# sysstat: sar
echo 'ENABLED="true"' > /etc/default/sysstat
service sysstat restart

# sysctl parameters
cat > /etc/sysctl.conf <<EOF
net.ipv4.ip_local_port_range = 1024 65000

net.core.somaxconn = 32768

#net.ipv4.tcp_tw_reuse = 1
#net.ipv4.tcp_fin_timeout = 3
#net.ipv4.tcp_max_tw_buckets = 2000000

#net.core.netdev_max_backlog = 8192
EOF
sysctl -p

# ulimit
cat > /etc/security/limits.conf <<EOF
* soft nofile 40960
* hard nofile 40960
* soft stack 10240
* hard stack 10240
* soft nproc 65535
* hard nproc 65535
EOF
