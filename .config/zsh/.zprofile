#!/bin/zsh

[ -f "$ZDOTDIR/.zshrc" ] && source "$ZDOTDIR/.zshrc"

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
	startx
fi
