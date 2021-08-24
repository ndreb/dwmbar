#!/bin/sh

net_check() {
    ping -c 1 www.google.com && echo "UP" > /tmp/network_status.tmp \
    || echo > /tmp/network_status.tmp
}

while true; do
    net_check
    sleep 15
done
