#!/bin/sh

update() {
    if curl "wttr.in?format=%C+%t" > /tmp/weather_report.tmp
    then
        return 0
    else
        echo "..." > /tmp/weather_report.tmp
    fi
}

while true; do
    update
    sleep 300
done
