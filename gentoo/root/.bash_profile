#!/bin/bash

# Figure out what Distro we are in
CURRENT_DISTRO="$(. /etc/os-release; printf '%s' $NAME)"

[[ "$(tty)" = *pts* ]] && export TERM=foot

export CURRENT_DISTRO WITHIN_KNOWN_CHROOT

[ -f ~/.bashrc ] && . ~/.bashrc
