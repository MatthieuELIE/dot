#!/usr/bin/env bash
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // .workspace.current_dir // "."')
dir=$(basename "$cwd")
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
usage=$(printf '%s' "$input" | ccusage statusline 2>/dev/null)

loc="📁 $dir"
[ -n "$branch" ] && loc="$loc 🌿 $branch"

printf '%s | %s\n' "$loc" "$usage"
