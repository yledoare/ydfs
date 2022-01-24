#!/bin/sh
echo "$1" | grep "button/lid" && grep -q open /proc/acpi/button/lid/LID0/state && exit 0
sync
sleep 2 && echo -n "mem" > /sys/power/state
