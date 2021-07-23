#!/bin/sh
# Check DualShock 4 Battery Level

read -r bat < /sys/class/power_supply/sony_controller_battery_00:1f:e2:c9:af:c4/capacity
printf '%s' "$bat%"
