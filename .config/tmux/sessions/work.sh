#!/usr/bin/env bash

NAME="$1"
BASE_DIR="$HOME/.config/tmux/sessions/scripts"
SESSION_SCRIPT="$BASE_DIR/$NAME.sh"

if [ -z "$NAME" ]; then
    echo "No session name provided. Usage: work <name>"
    exit 1
fi

if [ ! -f "$SESSION_SCRIPT" ]; then
    echo "No script found for '$NAME' in $BASE_DIR"
    exit 1
fi

if tmux has-session -t "$NAME" 2>/dev/null; then
    tmux attach -t "$NAME"
    exit 0
fi

"$SESSION_SCRIPT"
