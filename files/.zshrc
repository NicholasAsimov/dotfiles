#------------------------------
# History settings
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=999999

#------------------------------
# Environment variables
#------------------------------
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL=nvim

# `less` configuration
# R - interpret ANSI escape sequences
# F - automatically quit if one screen
# X - disable sending the termcap strings
export LESS=RFX

export GOPATH="$HOME/code/go"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$PATH:$GOPATH/bin:$NPM_CONFIG_PREFIX/bin"

# fzf settings
export FZF_DEFAULT_COMMAND="fd --ignore-file $HOME/.ignore --hidden --follow --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --ignore-file $HOME/.ignore --hidden --type d . /"

export WAYLAND_DISPLAY=wayland-0 # TODO why is this needed and not automatic?

#------------------------------
# Aliases
#------------------------------
alias e="$EDITOR"

alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gs="git status"

alias ls="ls --color -F"
alias ll="ls --color -lh"

alias vi="nvim"
alias vim="nvim"

alias vimconf="vi ~/.config/nvim/init.vim"

#------------------------------
# Keybindings
#------------------------------
# Select 'vim' keymap  (see also zshzle(1) man page)
bindkey -v

# Allow backspace to delete chars after entering Insert mode
bindkey "^?" backward-delete-char

# <jj> to exit Insert mode
bindkey -M viins "jj" vi-cmd-mode

# Make 'home' and 'end' buttons work as expected
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Search through history (see 'Completion' section)
# using <j> and <k> in Normal mode or <^P> and <^N> in Insert mode
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

bindkey -M viins "^P" up-line-or-beginning-search
bindkey -M viins "^N" down-line-or-beginning-search

# Edit current line in editor using <v> in Normal mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#------------------------------
# Prompt
#------------------------------
# Pure prompt
autoload -U promptinit; promptinit
prompt pure

#------------------------------
# Completion
#------------------------------
zstyle :compinstall filename '/home/rockstar/.zshrc'

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*:pacman:*' force-list always

# Search through history for previous commands matching everything up to current cursor position.
# Move the cursor to the end of line after each match.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -Uz compinit
compinit

# Kubernetes client completion
source <(kubectl completion zsh)
source <(helm completion zsh)

#------------------------------
# Miscellaneous
#------------------------------
# Automatically cd into the directory if it's the only argument
setopt autocd
# Share history between shells
setopt sharehistory
# Ignore duplicates of previous command
setopt histignoredups

# Activate fzf keybindings (^R to search history, ^T to find files, M+C to cd)
source /usr/share/fzf/key-bindings.zsh

# Override CTRL-R - Paste the selected command from history into the command line.
# This version also removes duplicates.
# Thanks to https://github.com/junegunn/fzf/pull/1287.
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  # TODO simplify this deduplication
  selected=( $(fc -rl 1 | sort -nr | sort -uk2 | sort -nr |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

# Activate fish-like syntax highlighting (has to be the last line)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

