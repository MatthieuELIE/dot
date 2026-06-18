#!/usr/bin/env bash

SESSION_NAME="actual"
PROJECT_DIR="$HOME/work/projects/actual"
FIFO="$HOME/dc_ready"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux attach -t "$SESSION_NAME"
    exit 0
fi

[ -p "$FIFO" ] && rm "$FIFO"
mkfifo "$FIFO"

tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n nvim

tmux send-keys -t "$SESSION_NAME:nvim" "cd $PROJECT_DIR" C-m
tmux send-keys -t "$SESSION_NAME:nvim" "dcup" C-m
tmux send-keys -t "$SESSION_NAME:nvim" "echo ok > $FIFO" C-m
tmux send-keys -t "$SESSION_NAME:nvim" "cd frontend && nvim" C-m

tmux new-window -t "$SESSION_NAME" -n backend -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:backend" "read < $FIFO" C-m
tmux send-keys -t "$SESSION_NAME:backend" "dcsym" C-m

tmux new-window -t "$SESSION_NAME" -n frontend -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:frontend" "read < $FIFO" C-m
tmux send-keys -t "$SESSION_NAME:frontend" "dcnpm" C-m

tmux new-window -t "$SESSION_NAME" -n app -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:app" "read < $FIFO" C-m
tmux send-keys -t "$SESSION_NAME:app" "dcapp; tmux kill-window -t '$SESSION_NAME:app'" C-m

tmux select-window -t "$SESSION_NAME:nvim"
tmux attach -t "$SESSION_NAME"
