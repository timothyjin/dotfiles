#!/bin/zsh

export PATH="$PATH:$(find "$HOME/.local/bin/" -type d | paste -sd:)"

export INTERNAL_INTEL="eDP-1"
export INTERNAL_NVIDIA="eDP-1-1"
export EXTERNAL="DP-1"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE="lf"
export READER="zathura"
export LOCKER="lock"
export LAUNCHER="rofi -modi drun,window,ssh -show"
export TRASH_DIR="$HOME/.local/share/Trash"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export ZDOTDIR="$HOME/.config/zsh"
