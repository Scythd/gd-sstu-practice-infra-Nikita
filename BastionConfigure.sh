#!/bin/bash


config_file=$(find / -name "sshd_config" 2>/dev/null)
sudo sed -i 's/#Port 22/Port 2047/g' ${config_file:--}
sudo sed -i 's/Port 22/Port 2047/g' ${config_file:--}
sudo /sbin/iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 2047 -j ACCEPT
sudo service sshd restart

