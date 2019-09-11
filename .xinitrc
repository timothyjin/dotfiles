#!/bin/sh

# Apply colors and transparency
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Disable beep
xset b off

# Apply input peripheral properties
[ -f ~/.xprofile ] && ~/.xprofile

exec i3
