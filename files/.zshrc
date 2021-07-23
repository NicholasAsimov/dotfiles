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
export DIFFPROG="nvim -d"

# `less` configuration
# R - interpret ANSI escape sequences
# F - automatically quit if one screen
# X - disable sending the termcap strings
export LESS=RFX

export GOPATH="$HOME/code/go"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$PATH:$GOPATH/bin:$NPM_CONFIG_PREFIX/bin:$HOME/.cargo/bin:$HOME/.scripts"

# fzf settings
export FZF_DEFAULT_COMMAND="fd --ignore-file $HOME/.ignore --hidden --follow --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --ignore-file $HOME/.ignore --hidden --type d . /"

export FZF_DEFAULT_OPTS='--bind ctrl-a:select-all --bind tab:down --bind btab:up --cycle'

# misc
export MOZCONFIG="$HOME/.mozconfig"
export CHROME_BIN=/usr/bin/chromium
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

export AWS_DEFAULT_PROFILE=nebula-dev-mwb-dev

#------------------------------
# Aliases
#------------------------------
alias e="$EDITOR"

alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gs="git status"
alias gg="git gui"
alias gl="git log"

alias ls="ls --color -F"
alias ll="ls --color -lh"

alias vi="nvim"
alias vim="nvim"

alias diff="git diff --no-index"

alias tf="terraform"

alias vimconf="vi ~/.config/nvim/init.vim"

function pkginfo { pacman -Qi $1 && pactree -r $1 }


# jq that ignores invalid json lines.
# Helpful for streaming mixed json and plaintext logs
function jqq {
    jq -R -r "${1:-.} as \$line | try fromjson catch \$line"
}

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

# Load CLI tools completions
source <(kubectl completion zsh)
source <(helm completion zsh)
source <(stern --completion=zsh)

complete -o nospace -C /usr/bin/terraform terraform
complete -C /usr/bin/aws_completer aws

#------------------------------
# Miscellaneous
#------------------------------
# Automatically cd into the directory if it's the only argument
setopt autocd
# Share history between shells
setopt sharehistory
# Ignore duplicates of previous command
setopt histignoredups
# Ignore command lines that start with space
setopt histignorespace

# Step through local history when using Up/Down arrows with shared history.
function up-line-or-history() {
    zle set-local-history 1
    zle .up-line-or-history
    zle set-local-history 0
}

function down-line-or-history() {
    zle set-local-history 1
    zle .down-line-or-history
    zle set-local-history 0
}

zle -N up-line-or-history
zle -N down-line-or-history

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

