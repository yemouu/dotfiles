#!/bin/bash
# Don't continue if we aren't interactive
[[ $- = *i* ]] || return

[[ $WITHIN_KNOWN_CHROOT = "true" ]] && PS1="(${CURRENT_DISTRO}) $PS1"
