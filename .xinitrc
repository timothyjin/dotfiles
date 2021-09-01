#!/bin/sh

# Nvidia KMS
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

prime-offload

# Apply colors and transparency
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Set wal colorscheme
wal --theme base16-twilight

# Apply input peripheral properties, start external applications
[ -f ~/.xprofile ] && . ~/.xprofile

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

session=${1:-bspwm}
case $session in
    bspwm             ) exec bspwm ;;
    i3|i3wm           ) exec i3 ;;
    xmonad|Xmonad     ) exec xmonad ;;
    kde               ) exec startplasma-x11 ;;
    *                 ) exec $1 ;;
esac
