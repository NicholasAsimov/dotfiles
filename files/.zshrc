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
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"

#------------------------------
# Aliases
#------------------------------
alias e="$EDITOR"

alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gs="git status"

alias ls="ls --color -F"
alias ll="ls --color -lh"

alias vi="nvim"
alias vim="nvim"
eval "$(thefuck --alias)"

#------------------------------
# Keybindings
#------------------------------
# Select 'vim' keymap  (see also zshzle(1) man page)
bindkey -v

# <jj> to exit Insert mode
bindkey -M viins "jj" vi-cmd-mode

# Make 'home' and 'end' buttons work as expected
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Search through history (see 'Completion' section)
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

#------------------------------
# Prompt
#------------------------------
# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Right prompt that indicates current vi mode
vim_ins_mode="[INS]"
vim_cmd_mode="[CMD]"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

RPROMPT='${vim_mode}'

# Do not display modes for previously accepted lines
setopt transient_rprompt
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

#------------------------------
# Miscellaneous
#------------------------------
# Automatically cd into the directory if it's the only argument
setopt autocd
# Share history between shells
setopt sharehistory
# Ignore duplicates of previous command
setopt histignoredups

# Activate fish-like syntax highlighting (has to be the last line)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
