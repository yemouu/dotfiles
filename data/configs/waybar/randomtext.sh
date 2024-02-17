#!/bin/sh
# Pick a random line from

printf '%s' "$(shuf "${XDG_CONFIG_HOME:-$HOME/.config}/waybar/random.txt" | head -n1)"
