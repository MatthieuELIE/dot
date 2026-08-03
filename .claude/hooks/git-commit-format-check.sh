#!/usr/bin/env bash
# Enforces header-only commit messages: "type(scope): summary", max 100 chars,
# no body, no Co-Authored-By trailer, for `git commit -m ...` (including the
# heredoc style `-m "$(cat <<'EOF' ...)"`, any delimiter).
#
# This is text-based parsing of a raw shell command string, not a real shell
# parser. It targets the realistic patterns Claude Code produces for its own
# commits, not adversarial shell escaping.
set -euo pipefail

# Extracts every `-m "..."` / `-m '...'` argument (each becomes a paragraph,
# joined by a blank line, matching how git concatenates multiple -m flags).
# Matches the closing quote to the SAME type as the opening one, so a message
# quoted with " can safely contain a ' (e.g. "fix: it's broken") and vice versa.
extract_dash_m_messages() {
    local remaining="$1"
    local re="-m[[:space:]]+(\"([^\"]*)\"|'([^']*)'|([^[:space:]]+))"
    while [[ "$remaining" =~ $re ]]; do
        if [ "${BASH_REMATCH[1]:0:1}" = '"' ]; then
            printf '%s\n\n' "${BASH_REMATCH[2]}"
        elif [ "${BASH_REMATCH[1]:0:1}" = "'" ]; then
            printf '%s\n\n' "${BASH_REMATCH[3]}"
        else
            printf '%s\n\n' "${BASH_REMATCH[4]}"
        fi
        remaining="${remaining#*"${BASH_REMATCH[0]}"}"
    done
}

# Truncates $1 at the first top-level (unquoted) command separator (; & |),
# so a chained command after the real `git commit` (e.g. `git commit -m "x"
# && echo "-m mention"`) doesn't leak its own `-m` flags into the message.
truncate_at_next_command() {
    local s="$1" state=none i c out=""
    for (( i = 0; i < ${#s}; i++ )); do
        c="${s:i:1}"
        case "$state" in
            none)
                case "$c" in
                    "'") state=single ;;
                    '"') state=double ;;
                    ';'|'&'|'|') printf '%s' "$out"; return ;;
                esac
                ;;
            single) [ "$c" = "'" ] && state=none ;;
            double)
                if [ "$c" = '\' ]; then
                    out+="$c${s:i+1:1}"
                    i=$((i + 1))
                    continue
                elif [ "$c" = '"' ]; then
                    state=none
                fi
                ;;
        esac
        out+="$c"
    done
    printf '%s' "$out"
}

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

cmd=$(jq -r '.tool_input.command // empty')

commit_regex='(^|[;&|]) *git commit\b'
printf '%s' "$cmd" | grep -qEi "${commit_regex}.*-m" || exit 0

first_match=$(printf '%s' "$cmd" | grep -oEi "$commit_regex" | head -1)
prefix="${cmd%%"$first_match"*}"
in_open_quote "$prefix" && exit 0

# Everything from here on parses only the real invocation, not the whole
# command - an unrelated `-m <word>` elsewhere in a chained command (e.g.
# `echo "with -m flag" && git commit ...`) must not pollute message extraction.
# $first_match includes the leading separator/anchor (^ or one of ;&|) that
# introduced this invocation, so strip it back off before scanning forward.
commit_start="${cmd#"$prefix"}"
commit_start="$(printf '%s' "$commit_start" | sed -E 's/^[;&|]?[[:space:]]*//')"

heredoc_re="(<<-?)[\"']?([A-Za-z_][A-Za-z0-9_]*)[\"']?"
if [[ "$commit_start" =~ $heredoc_re ]]; then
    operator="${BASH_REMATCH[1]}"
    delimiter="${BASH_REMATCH[2]}"
    start_line=$(printf '%s\n' "$commit_start" | grep -nE -- "${operator}[\"']?${delimiter}[\"']?" | head -1 | cut -d: -f1)
    if [ "$operator" = "<<-" ]; then
        # <<- strips leading tabs from both the end delimiter and every content line.
        end_pattern="^[[:space:]]*${delimiter}[[:space:]]*$"
        full_message=$(printf '%s\n' "$commit_start" | tail -n +"$((start_line + 1))" | sed -n "/${end_pattern}/q;p" | sed 's/^\t*//')
    else
        end_pattern="^${delimiter}[[:space:]]*$"
        full_message=$(printf '%s\n' "$commit_start" | tail -n +"$((start_line + 1))" | sed -n "/${end_pattern}/q;p")
    fi
else
    full_message=$(extract_dash_m_messages "$(truncate_at_next_command "$commit_start")")
fi

[ -z "$full_message" ] && exit 0

header=$(printf '%s\n' "$full_message" | head -1)
non_empty_lines=$(printf '%s\n' "$full_message" | sed -e '/^[[:space:]]*$/d' | wc -l | tr -d ' ')

reason=""
if printf '%s' "$full_message" | grep -qi 'co-authored-by:'; then
    reason="Commit message must not include a Co-Authored-By trailer."
elif [ "$non_empty_lines" -gt 1 ]; then
    reason="Commit message must be header-only (no body). Got $non_empty_lines non-blank lines."
elif ! printf '%s' "$header" | grep -qE "^[a-z]+\([a-z0-9._/-]+\): .+\$"; then
    reason="Commit header must match 'type(scope): summary'. Got: \"$header\""
elif [ "${#header}" -gt 100 ]; then
    reason="Commit header is ${#header} chars, max 100: \"$header\""
fi

if [ -n "$reason" ]; then
    jq -cn --arg reason "$reason" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
fi
