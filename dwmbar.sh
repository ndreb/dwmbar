#!/bin/sh

battery() {
    echo "|  $(cat /sys/class/power_supply/BAT0/capacity)%"
}

cpu_perc() {
    echo "|  $(cat /tmp/cpu_perc.tmp) "
}

cpu_temp() {
    echo " $(($(cat /sys/class/thermal/thermal_zone8/temp)/1000))°C"
}

mem_avail() {
    awk 'FNR == 3 {printf "%lu", $2}' "/proc/meminfo"
}

mem_total() {
    awk 'FNR == 1 {printf "%lu", $2}' "/proc/meminfo"
}

mem_used() {
    echo "|  $((($(mem_total)-$(mem_avail))/1024)) MiB"
}

network() {
    grep -q "up" /sys/class/net/*/operstate && echo "|  |" || echo "|  |"
}

status_bar() {
    echo "$(weather) $(cpu_perc) $(cpu_temp) $(mem_used) $(battery)" \
        "$(network) $(vpn_opstate) $(date)"
    }

vpn_opstate() {
    if [ -f /sys/class/net/tun0/subsystem/wlp0s20f3/operstate ]
    then
        echo " |"
    else
        echo " |"
    fi
}

weather() {
    cat /tmp/weather_report.tmp
}

sh ~/suckless/dwmbar/get_weather.sh >/dev/null 2>&1 &

[ ! -f /tmp/cpu_perc.tmp ] && touch /tmp/cpu_perc.tmp

awk -f ~/suckless/dwmbar/cpu.awk >/dev/null 2>&1 &

sleep 1

while true; do
    xsetroot -name " $(status_bar) "
    sleep 1
done
