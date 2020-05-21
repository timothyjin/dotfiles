#!/bin/zsh

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE="lf"
export READER="zathura"
export LOCKER="lock"
export TRASH_DIR="$HOME/.local/share/Trash"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export ZDOTDIR="$HOME/.config/zsh"

export PATH="$PATH:$(find "$HOME/.local/bin/" -type d | paste -sd:)"
