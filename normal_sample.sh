#!/bin/bash

iptables -F
iptables -X
iptables -Z

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -s 0/0 -d 123.123.123.234 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -i eth1 -p tcp --dport 53 -j ACCEPT ## dns
iptables -A INPUT -i eth1 -p tcp --dport 22 -j ACCEPT ## ssh

iptables -A INPUT -s 123.123.123.123 -d 123.123.123.234 -j ACCEPT ## allow all for xxxx
iptables -A INPUT -s 123.123.123.124 -d 123.123.123.234 -j ACCEPT
iptables -A INPUT -s 123.123.123.125 -d 123.123.123.234 -j ACCEPT
iptables -A INPUT -s 123.123.123.126 -d 123.123.123.234 -j ACCEPT
iptables -A INPUT -s 123.123.123.127 -d 123.123.123.234 -j ACCEPT


iptables-save > /etc/sysconfig/iptables ## save the rules
service iptables restart
