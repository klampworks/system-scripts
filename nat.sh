#!/bin/bash

#Redirect traffic from one interface to another, in this case redirecting
#an ethernet connection to wireless.

if [[ $EUID -ne 0 ]]; then
	echo "Run as root." 2>&1
	exit 1
fi

from="eth0"
to="wlan0"
ifconfig $to up
ifconfig $from up
ifconfig $to 192.168.0.1 netmask 255.255.255.0

#This is a dhcp server. An alternative would be to set a statis ip on whatever
#is connected to the other end of the ethernet cable.
dnsmasq -p 4563  &

iptables -F
iptables -t nat -F
iptables -A FORWARD -i $from -d 192.168.0.0/255.255.0.0 -j ACCEPT
iptables -t nat -A POSTROUTING -o $from -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
