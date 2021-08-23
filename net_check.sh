#!/bin/sh

net_check() {
    if ping -c 1 www.google.com
    then
        echo "UP" > /tmp/network_status.tmp
    else
        echo > /tmp/network_status.tmp
    fi
}

while true; do
    net_check
    sleep 15
done
