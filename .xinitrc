#!/bin/sh

# Apply colors and transparency
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
wal --theme base16-twilight

# Apply input peripheral properties, start external applications
[ -f ~/.xprofile ] && . ~/.xprofile

session=${1:-i3}
case $session in
    i3|i3wm           ) exec i3;;
    bsp|bspwm         ) sxhkd &; exec bspwm;;
    kde               ) exec startplasma-x11;;
    *                 ) exec $1;;
esac
