#!/bin/bash
iptables -F
iptables -X
iptables -Z

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 4 --packet 0 -o ens160 -j SNAT --to-source 192.168.238.216
iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 4 --packet 1 -o ens160 -j SNAT --to-source 192.168.238.219
iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 4 --packet 2 -o ens160 -j SNAT --to-source 192.168.238.218

#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .25 -o ens160 -j SNAT --to-source 192.168.238.217
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .25 -o ens160 -j SNAT --to-source 192.168.238.218
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .25 -o ens160 -j SNAT --to-source 192.168.238.219
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .25 -o ens160 -j SNAT --to-source 192.168.238.221
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .25 -o ens160 -j SNAT --to-source 192.168.238.216

iptables-save > /etc/sysconfig/iptables ## save the rules
service iptables restart
