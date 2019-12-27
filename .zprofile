#!/bin/zsh

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE="lf"
export READER="zathura"
export LOCKER="lock"
# export ZDOTDIR="$HOME/.config/zsh"
export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"

[ -f $HOME/.zshrc ] && source "$HOME/.zshrc"

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
	startx
fi
