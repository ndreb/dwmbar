#!/bin/sh

update() {
    curl "wttr.in?format=%C+%t" > /tmp/weather_report.tmp \
    || echo "..." > /tmp/weather_report.tmp
}

while true; do
    update
    sleep 300
done
