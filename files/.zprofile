# Autostart sway on 1st tty
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    # Sway understands xkb environment variables
    export XKB_DEFAULT_LAYOUT=us,ru
    export XKB_DEFAULT_OPTIONS=grp:win_space_toggle,

    # Replace current shell with sway without spawning a new process
    exec sway
fi
