#!/bin/sh
# shellcheck source=/dev/null
. "${XDG_STATE_HOME:-$HOME/.local/state}/thm/colors.sh"

# shellcheck disable=SC2154
exec bemenu-run -i \
                         -w \
                         -p run: \
                         -m all \
                         -H 32 \
                         --ch 24 \
                         --cw 4 \
                         --hp 4 \
                         --fn "monospace 10" \
                         --tb "#${bg_color}" \
                         --tf "#${color5}" \
                         --fb "#${bg_color}" \
                         --ff "#${color5}" \
                         --nb "#${bg_color}" \
                         --nf "#${color8}" \
                         --hb "#${bg_color}" \
                         --hf "#${fg_color}" \
                         --fbb "#${color9}" \
                         --fbf "#${color9}" \
                         --sb "#${color9}" \
                         --sf "#${color9}" \
                         --ab "#${bg_color}" \
                         --af "#${color8}" \
                         --scb "#${color9}" \
                         --scf "#${color9}" \
                         --bdr "#${color9}" \
                         "$@"
