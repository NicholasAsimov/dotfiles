# Load resource file
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set default terminal
export TERMINAL=lilyterm

# Set keyboard layout to US and RU with Super+Space shortcut for switching between them
setxkbmap -model pc104 -layout us,ru -option grp:win_space_toggle
# export XKB_DEFAULT_LAYOUT=us,ru
# export XKB_DEFAULT_OPTIONS=grp:win_space_toggle,

# Start i3 window manager
exec i3
