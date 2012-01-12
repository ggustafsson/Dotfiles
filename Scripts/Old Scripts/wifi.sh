#!/usr/bin/env bash

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

ip link set wlan0 up
wpa_supplicant -D nl80211 -i wlan0 -c /etc/wpa_supplicant.conf &
sleep 5 && dhcpcd wlan0

