#!/bin/bash

export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | tr '\n' ':')"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"
export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"

[[ -f ~/.bashrc ]] && source "$HOME/.bashrc"

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
	startx
fi
