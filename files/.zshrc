#------------------------------
# History settings
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=999999

#------------------------------
# Aliases
#------------------------------
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gs="git status"

alias ls="ls --color -F"
alias ll="ls --color -lh"

eval "$(thefuck --alias)"

#------------------------------
# Environment variables
#------------------------------
export TERM=xterm-256color
export EDITOR=micro
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"

#------------------------------
# Keybindings
#------------------------------
# Select 'emacs' keymap  (see also zshzle(1) man page)
bindkey -e

# Make 'home' and 'end' buttons work as expected
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Search through history (see 'Completion' section)
bindkey "\e[A" up-line-or-beginning-search # Up arrow
bindkey "\e[B" down-line-or-beginning-search # Down arrow

#------------------------------
# Prompt
#------------------------------
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
