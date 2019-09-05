#!/bin/sh

# Remap Escape and CapsLock
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Apply colors and transparency
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Disable beep
xset b off

TPOINT="TPPS/2 Elan TrackPoint"
TPAD="SynPS/2 Synaptics TouchPad"
WR_MOUSE="Logitech G403 Prodigy Wired/Wireless Gaming Mouse"
WL_MOUSE="Logitech USB Receiver Mouse"
MSPEED="0.5"

# TrackPoint, TouchPad, mouse settings
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Profile Enabled" 1, 0
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xinput list | grep -q "$WR_MOUSE" && xinput set-prop "$WR_MOUSE" "libinput Accel Speed" 0.4
xinput list | grep -q "$WL_MOUSE" && xinput set-prop "$WL_MOUSE" "libinput Accel Speed" 0.4

# Turn on NumLock
numlockx &

exec i3
