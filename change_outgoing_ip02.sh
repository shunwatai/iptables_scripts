#!/bin/bash

systemctl restart iptables
iptables -F
iptables -X
iptables -Z

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#iptables -A INPUT -p tcp --dport 25 -j ACCEPT

iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 3 --packet 0 -o eno16777984 -j SNAT --to-source 132.123.123.201
iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -o eno16777984 -j SNAT --to-source 132.123.123.202
iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode nth --every 1 --packet 0 -o eno16777984 -j SNAT --to-source 132.123.123.203

#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .33 -o eno16777984 -j SNAT --to-source 132.123.123.201
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .33 -o eno16777984 -j SNAT --to-source 132.123.123.202
#iptables -t nat -A POSTROUTING -m state --state NEW -m statistic --mode random --probability .33 -o eno16777984 -j SNAT --to-source 132.123.123.203

iptables-save > /etc/sysconfig/iptables ## save the rules
service iptables restart
