#!/bin/zsh

export XDG_CONFIG_HOME="$HOME/.config"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export KDEHOME="$XDG_CONFIG_HOME/kde"

export XDG_DATA_HOME="$HOME/.local/share"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export HISTFILE="$XDG_DATA_HOME/zsh_history"
export NPM_CONFIG_USER_CONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PLTUSERHOME="$XDG_DATA_HOME/racket"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

export XDG_CACHE_HOME="$HOME/.cache"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

export LESSHISTFILE="-"

[ -f "$ZDOTDIR/.zshrc" ] && source "$ZDOTDIR/.zshrc"

# if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
# 	startx
# fi
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx
