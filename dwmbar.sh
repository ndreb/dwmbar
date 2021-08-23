#!/bin/sh

[ ! -f /tmp/network_status.tmp ] && touch /tmp/network_status.tmp

[ ! -f /tmp/weather_report.tmp ] && touch /tmp/weather_report.tmp

sh ~/suckless/dwmbar/net_check.sh >/dev/null 2>&1 &

sh ~/suckless/dwmbar/get_weather.sh >/dev/null 2>&1 &

sleep 1

weather() {
    cat /tmp/weather_report.tmp
}

network() {
    if grep -q "UP" /tmp/network_status.tmp
    then
        echo "| "
    else
        echo "| "
    fi
}

battery() {
    echo "|  $(cat "/sys/class/power_supply/BAT0/capacity")% |"
}

memory() {
    printf '%s %i %s\n' "" "$(free -m | awk 'FNR == 2 {print ($3+$6)}')" "mb |"
}

cpu() {
    echo " 00% |"
}

status_bar() {
    echo "$(weather) $(network) $(battery) $(memory) $(cpu) $(date)"
}

while true; do
    xsetroot -name " $(status_bar) "
    sleep 1
done
