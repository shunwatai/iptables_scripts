# What 7 these?

They are just some scripts of iptables for changing the outgoing IP addresses in "packets interval" or "random probaility" manner. Nothing special, just for self reference.

# How to use?

## method 1 - add alias

add addition alias IPs for the network interface

    ifconfig eth0:0 123.123.123.123/24 up # for tmp only. google for permanently
    ifconfig eth0:1 123.123.123.124/24 up
    ...

    ./change_outgoing_ip02.sh

## method2 - for more than one physical interface

You get the idea
