autoload -U colors && colors

ZSH_CACHE_DIR=$HOME/.cache/zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# Include hidden files.
_comp_options+=(globdots)

HISTSIZE=10000000
SAVEHIST=10000000

# tmux variables
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"
ZSH_TMUX_UNICODE=true

export DISABLE_AUTO_UPDATE="true"
export FZF_DEFAULT_COMMAND="fd -H --no-ignore-vcs --full-path -a -t f --ignore-file ~/.config/fd/ignore $HOME"

# Load zgen
source "${HOME}/.zgen/zgen.zsh"

# Create init script if it does not exist
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/virtualenv
    zgen load subnixr/minimal
    zgen load zsh-users/zsh-syntax-highlighting

    zgen save
fi

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
# zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
# zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Use lf to switch directories and bind it to ctrl-f
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^f' 'lfcd\n'

# Load aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
