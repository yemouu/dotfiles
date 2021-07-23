#!/bin/sh
# Print the 1 minute loadaverage

read -r loadaverage _ _ _ _ < /proc/loadavg
printf '%s' "$loadaverage"
