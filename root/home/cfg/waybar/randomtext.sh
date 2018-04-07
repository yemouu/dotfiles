#!/bin/sh
# Pick a random line from

printf '%s' "$(shuf "$HOME/cfg/waybar/random.txt" | head -n1)"
