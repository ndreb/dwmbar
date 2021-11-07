#!/bin/sh

while true; do

    [ ! -f /tmp/weather_report.tmp ] && touch /tmp/weather_report.tmp

    curl "wttr.in?format=%C+%t&?m" > /tmp/weather_report.tmp \
    || echo "..." > /tmp/weather_report.tmp

    sleep 300

done
