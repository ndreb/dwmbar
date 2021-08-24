#!/bin/sh

while true; do

    [ ! -f /tmp/network_status.tmp ] && touch /tmp/network_status.tmp

    ping -c 1 www.google.com && echo "UP" > /tmp/network_status.tmp \
    || echo > /tmp/network_status.tmp

    sleep 15

done
