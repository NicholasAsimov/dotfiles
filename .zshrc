# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=999999
setopt autocd
bindkey -e
eval "$(thefuck --alias)"


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rockstar/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Activate fish-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh