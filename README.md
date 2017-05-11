# dotfiles

## File structure
```
.
├── files
│   ├── .config
│   │   ├── fontconfig
│   │   │   ├── conf.d
│   │   │   │   └── 01-emoji.conf
│   │   │   └── fonts.conf
│   │   ├── gtk-2.0
│   │   │   └── gtkfilechooser.ini
│   │   ├── gtk-3.0
│   │   │   └── settings.ini
│   │   ├── i3blocks
│   │   │   └── config
│   │   ├── lilyterm
│   │   │   └── default.conf
│   │   ├── micro
│   │   │   ├── bindings.json
│   │   │   ├── init.lua
│   │   │   └── settings.json
│   │   ├── nvim
│   │   │   ├── colors
│   │   │   │   └── Tomorrow-Night-Eighties.vim
│   │   │   └── init.vim
│   │   └── sway
│   │       └── config
│   ├── pictures
│   │   └── wallpapers
│   │       ├── cube.jpg
│   │       └── owl.png
│   ├── .gitconfig
│   ├── .gtkrc-2.0
│   ├── .zprofile
│   └── .zshrc
├── arch-setup.sh
├── LICENSE
├── README.md
└── setup.sh
```

## Setup scripts
- *setup.sh* - Base installation script that symlinks the files to the home directory and installs pure prompt and dein.vim (plugin manager) if they're not already installed.
- *arch-setup.sh* - Arch-specific installation script that installs yaourt (AUR wrapper) and required packages.
