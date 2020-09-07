#!/bin/sh

# Apply colors and transparency
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Apply input peripheral properties, start external applications
[ -f ~/.xprofile ] && . ~/.xprofile

session=${1:-i3}
case $session in
    i3|i3wm           ) exec i3 ;;
    xmonad|Xmonad     ) exec xmonad ;;
    kde               ) exec startplasma-x11 ;;
    *                 ) exec $1 ;;
esac
