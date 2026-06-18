#!/usr/bin/env bash

SESSION_NAME="sofie"
PROJECT_DIR="$HOME/work/projects/sfe-app-supervision"
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

tmux new-window -t "$SESSION_NAME" -n bootstrap -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:bootstrap" "read < $FIFO" C-m
tmux send-keys -t "$SESSION_NAME:bootstrap" '
CID=$(docker ps -q --latest)
IP=$(docker inspect -f '"'"'{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"'"' $CID)
docker run -d --rm -p 8000:8000 alpine/socat TCP-LISTEN:8000,fork TCP:$IP:8000
docker run -d --rm -p 5173:5173 alpine/socat TCP-LISTEN:5173,fork TCP:$IP:5173
exit
' C-m

tmux select-window -t "$SESSION_NAME:nvim"
tmux attach -t "$SESSION_NAME"
