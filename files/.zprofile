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
    export WAYLAND_DISPLAY=wayland-0

    # Replace current shell with sway without spawning a new process
    exec sway
fi
