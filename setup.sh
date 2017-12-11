#!/bin/bash

params="-sf"

while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done

# Symlink each file in 'files' directory to corresponding location in $HOME
cd files

# $filepath is a path to the file relative to the 'files' folder
# e.g. ./.zshrc
for filepath in `find . -type f`; do
    # $source is an absolute path to the source file
    # e.g. /home/user/.dotfiles/files/.zshrc
    source=$(realpath $filepath)
    destination="$HOME/$filepath"

    # Make sure destination folder exists
    mkdir -p $(dirname $destination)
    ln $params $source $destination
done

# Symlink each file in 'scripts' directory to /usr/local/bin
cd ../scripts

for filepath in `find . -type f`; do
    source=$(realpath $filepath)
    destination="/usr/local/bin/$filepath"

    sudo ln $params $source $destination
done

cd /tmp

# Install zsh-pure-prompt
PURE_VERSION="1.6.0"
promptPath="/usr/share/zsh/site-functions/prompt_pure_setup"
asyncPath="/usr/share/zsh/site-functions/async"
if [ ! -f $promptPath ] || [ ! -f $asyncPath ]; then
    echo "pure-zsh is not installed, installing.."
    curl -L -o "pure.tar.gz" "https://github.com/sindresorhus/pure/archive/v${PURE_VERSION}.tar.gz"
    tar -xzf "pure.tar.gz"
    cd "pure-${PURE_VERSION}"
    sudo cp pure.zsh $promptPath
    sudo cp async.zsh $asyncPath
    cd ..
fi

# Install dein.vim
if [ ! -d "$HOME/.cache/dein" ]; then
    echo "dein.vim is not installed, installing.."
    curl -o installer.sh https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
    sh ./installer.sh "$HOME/.cache/dein"
fi
