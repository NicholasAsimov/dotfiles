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

cd ..

# Download zsh-pure-prompt
