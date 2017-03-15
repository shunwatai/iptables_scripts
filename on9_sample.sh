#!/bin/bash
while true
do
    ifconfig ens160 192.168.238.217 up
    route add default gw 192.168.238.254
    sleep 2
    ifconfig ens160 192.168.238.216 up
    route add default gw 192.168.238.254
    sleep 2
    ifconfig ens160 192.168.238.218 up
    route add default gw 192.168.238.254
    sleep 2
done
