#! /bin/sh

#Tor's listening port.
tor_port="9051"

#This will likely be debian-tor by default if 
#you're using a Debian based distro.
tor_user="tor"

#Network interface to allow.
interface="wlan0"

#The user to allow access to tor i.e. the user your web browser runs under.
user_user="my-pc"

iptables -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -P INPUT DROP
iptables -P OUTPUT DROP

iptables -I INPUT -j ACCEPT -i lo -p tcp --dport $tor_port --sport 1:65000
iptables -A OUTPUT -j ACCEPT -o lo -p tcp --dport 1:65000 --sport $tor_port

iptables -A OUTPUT -p tcp -j ACCEPT -m owner --uid-owner $tor_user -o lo
iptables -A OUTPUT -p tcp -j ACCEPT -m owner --uid-owner $user_user -o lo

iptables -A OUTPUT -p tcp -j ACCEPT -o $interface -m owner --uid-owner $tor_user
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

