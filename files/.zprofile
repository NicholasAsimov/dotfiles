# Start ssh-agent or source existing ssh-agent env
SSH_ENV="$HOME/.ssh/environment"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > $SSH_ENV
    chmod 600 $SSH_ENV
fi
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(<$SSH_ENV)"
fi

# Autostart sway on 1st tty
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]; then
    # TODO this is now handled by Arch sway package (https://bugs.archlinux.org/task/63021)
    # export WAYLAND_DISPLAY=wayland-0
    export MOZ_ENABLE_WAYLAND=1
    export _JAVA_AWT_WM_NONREPARENTING=1

    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland

    # Replace current shell with sway without spawning a new process
    exec sway
fi
