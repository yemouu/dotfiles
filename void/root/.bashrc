#!/bin/bash
# Don't continue if we aren't interactive
[[ $- = *i* ]] || return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w \$ \[\033[00m\]'

[[ $WITHIN_KNOWN_CHROOT = "true" ]] && PS1="(${CURRENT_DISTRO}) $PS1"
