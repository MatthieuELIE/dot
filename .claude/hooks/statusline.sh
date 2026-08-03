#!/usr/bin/env bash
input=$(cat)

dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // "."')
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')

cost=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(printf '%s' "$input" | jq -r '.cost.total_duration_ms // 0 | floor')
tokens=$(printf '%s' "$input" | jq -r '
  .context_window.current_usage as $u
  | if $u == null then 0
    else ($u.input_tokens // 0) + ($u.output_tokens // 0) + ($u.cache_creation_input_tokens // 0) + ($u.cache_read_input_tokens // 0)
    end
')
context_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // 200000')

line1="📁 Workspace: $(basename "$dir")"
[ -n "$branch" ] && line1="$line1 | 🌿 Branch: $branch"
line1="$line1 | 🤖 Model: $model"
[ -n "$effort" ] && line1="$line1 | ⚡ Effort: $effort"

duration_s=$(( duration_ms / 1000 ))
duration_fmt="$(( duration_s / 60 ))m$(( duration_s % 60 ))s"

pct=$(( context_size > 0 ? tokens * 100 / context_size : 0 ))

line2=$(printf '🧮 Context Tokens: %s (%s%%) | 💰 Cost: $%.4f | ⏱️ Duration: %s' "$tokens" "$pct" "$cost" "$duration_fmt")

printf '%s\n%s\n' "$line1" "$line2"
