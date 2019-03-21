#!/usr/bin/env bash

function install_yay() {
    pushd .
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    popd
}

cd /tmp

echo "Installing yay"
install_yay
