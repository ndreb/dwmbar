#!/bin/sh

battery() {
    echo "|  $(cat /sys/class/power_supply/BAT0/capacity)%"
}

cpu() {
    echo "|  $(sensors | awk 'FNR == 8 {print $4}') 00% |"
}

memory() {
    echo " $(free -m | awk 'FNR == 2 {print ($3+$6)}') MiB"
}

network() {
    grep -q "UP" /tmp/network_status.tmp && echo "|  |" || echo "|  |"
}

status_bar() {
    echo "$(weather) $(cpu) $(memory) $(battery) $(network) $(date)"
}

weather() {
    cat /tmp/weather_report.tmp
}

sh ~/suckless/dwmbar/net_check.sh >/dev/null 2>&1 &

sh ~/suckless/dwmbar/get_weather.sh >/dev/null 2>&1 &

sleep 1

while true; do
    xsetroot -name " $(status_bar) "
    sleep 1
done
