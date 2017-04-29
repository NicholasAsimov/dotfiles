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

for f in `find . -type f`; do
    filepath=$(realpath $f)
    ln $params $filepath $HOME/$f
done

cd ..

# Download zsh-pure-prompt
