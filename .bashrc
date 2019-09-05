#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Change into directory just by typing directory name
shopt -s autocd

# Add timestamps to bash history
#HISTTIMEFORMAT="%d/%m/%y %T "

# ----- PS1 format info ----- #
# Original PS1='[\u@\h \W]\$ '
# Green: 2
# Yellow (Orange): 3
# Blue: 4
# Cyan: 6
# White (Gray): 7
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\u@\h | \W]$ \[$(tput sgr0)\]"
#export PS1="\[$(tput bold)\]\[$(tput setab 7)\][\u@\h | \W]$\[$(tput setab 0)\] \[$(tput sgr0)\]"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
