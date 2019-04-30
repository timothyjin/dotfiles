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
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h | \W]$ \[$(tput sgr0)\]"
#export PS1="\[$(tput bold)\]\[$(tput setab 7)\][\u@\h | \W]$\[$(tput setab 0)\] \[$(tput sgr0)\]"

# ----- Command aliases ----- #
alias vim='nvim'
alias e="$EDITOR"
alias se='sudo "$EDITOR"'
alias f="$FILE"
alias sf='sudo "$FILE"'
alias ssc='sudo systemctl'
alias ff='sudo find / -name'
alias win='sudo efibootmgr -n 0000'
alias sdn='sudo shutdown -h now'
alias gs='git status'
alias cw='calcurse --day 7'
alias ytdl='youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0'

# Graphics information
alias glg='glxinfo | egrep "OpenGL vendor|OpenGL renderer"'

# ----- Directory shortcuts ----- #
alias h='cd ~/'
alias d='cd ~/Documents'
alias D='cd ~/Downloads'
alias m='cd ~/Music'
alias p='cd ~/Pictures'
alias cf='cd ~/.config'
alias sc='cd ~/.scripts'

# ----- School directory shortcuts ----- #
alias 338='cd ~/Documents/4-Spring2019/EECS-338'
alias 345='cd ~/Documents/4-Spring2019/EECS-345'
alias 391='cd ~/Documents/4-Spring2019/EECS-391'
alias 209='cd ~/Documents/4-Spring2019/USSO-209'

# ----- File shortcuts ----- #
alias cfp='"$EDITOR" ~/.bash_profile'
alias cfs='"$EDITOR" ~/.bashrc'
alias cft='"$EDITOR" ~/Repos/st/config.h'
alias cfv='"$EDITOR" ~/.config/nvim/init.vim'
alias cfi='"$EDITOR" ~/.config/i3/config'
alias cfb='"$EDITOR" ~/.config/i3blocks/config'
alias cfx='"$EDITOR" ~/.xinitrc'
alias cfr='"$EDITOR" ~/.Xresources'
alias cff='"$EDITOR" ~/.config/fontconfig/fonts.conf'

# ----- Aliases for color ----- #
alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
