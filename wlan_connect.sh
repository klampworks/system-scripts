#!/bin/bash

interface="wlan0"
conf="/etc/wpa_supplicant/wpa_supplicant.conf"

sudo -v
sudo killall wpa_supplicant dhcpcd
sudo wpa_supplicant -i $interface -c $conf &
sudo dhcpcd $interface &
