#!/bin/zsh

export PATH="$PATH:$(find "$HOME/.local/bin/" -type d | paste -sd:)"
