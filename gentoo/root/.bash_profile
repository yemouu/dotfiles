#!/bin/bash

# Figure out what Distro we are in
CURRENT_DISTRO="$(. /etc/os-release; printf '%s' $NAME)"

# Are we in a chroot that we know about?
[[ $CURRENT_DISTRO = "Gentoo" ]] && { findmnt /mnt/void > /dev/null 2>&1 \
	&& WITHIN_KNOWN_CHROOT=false || WITHIN_KNOWN_CHROOT=true; }
[[ $CURRENT_DISTRO = "void" ]] && { findmnt /mnt/gentoo > /dev/null 2>&1 \
	&& WITHIN_KNOWN_CHROOT=false || WITHIN_KNOWN_CHROOT=true; }

[[ "$(tty)" = *pts* ]] && export TERM=foot

export CURRENT_DISTRO WITHIN_KNOWN_CHROOT

[ -f ~/.bashrc ] && . ~/.bashrc
