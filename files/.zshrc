# History settings
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=999999

# Automatically cd into the directory if it's the only argument
setopt autocd

# Select 'emacs' keymap  (see also zshzle(1) man page)
bindkey -e

# Make 'home' and 'end' buttons work as expected
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Aliases
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gs="git status"
eval "$(thefuck --alias)"

# Go
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"

# The following lines were added by compinstall
# TODO figure out what this is
zstyle :compinstall filename '/home/rockstar/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Initialize pure prompt
autoload -U promptinit; promptinit
prompt pure

# Activate fish-like syntax highlighting (has to be the last line)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
