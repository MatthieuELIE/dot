#!/usr/bin/env bash
# Denies Read/Write/Edit/NotebookEdit/Grep/Glob/Bash actions whose target
# path resolves outside the directory the session was opened in (payload's
# .cwd). Bash coverage is best-effort: shell word-splitting on the command
# string, flagging absolute (/...), home (~...), and ../-relative tokens.
# Arbitrary shell syntax (quoting, subshells, env-var-built paths) can't be
# parsed reliably from outside the shell, so gaps remain by design.
set -uo pipefail

ALLOWLIST=(
    "/private/tmp"
    "/private/tmp/*"
    "$HOME/.claude"
    "$HOME/.claude/*"
    "$HOME/dot"
    "$HOME/dot/*"
)

payload="$(cat)"
tool="$(printf '%s' "$payload" | jq -r '.tool_name // empty')"
cwd_raw="$(printf '%s' "$payload" | jq -r '.cwd // empty')"
[ -n "$cwd_raw" ] || exit 0

resolve_path() {
    local p="$1"
    if [ -e "$p" ]; then
        realpath "$p" 2>/dev/null
        return
    fi
    local dir base parent
    dir="$(dirname "$p")"
    base="$(basename "$p")"
    if [ "$dir" = "$p" ]; then
        printf '%s' "$p"
        return
    fi
    parent="$(resolve_path "$dir")"
    [ -n "$parent" ] || return 1
    printf '%s/%s' "$parent" "$base"
}

cwd="$(resolve_path "$cwd_raw")"
[ -n "$cwd" ] || exit 0

is_outside() {
    local target="$1"
    target="${target%\"}"
    target="${target#\"}"
    target="${target%\'}"
    target="${target#\'}"
    case "$target" in
        "~"*) target="${HOME}${target#\~}" ;;
    esac
    case "$target" in
        /*) : ;;
        *) target="$cwd_raw/$target" ;;
    esac
    local real
    real="$(resolve_path "$target")"
    [ -n "$real" ] || return 1
    case "$real" in
        "$cwd"|"$cwd"/*) return 1 ;;
    esac
    for pattern in "${ALLOWLIST[@]}"; do
        case "$real" in
            $pattern) return 1 ;;
        esac
    done
    return 0
}

deny() {
    jq -n --arg reason "$1" \
        '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
    exit 0
}

case "$tool" in
    Read|Edit|Write)
        target="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"
        if [ -n "$target" ] && is_outside "$target"; then
            deny "Blocked: $target is outside the session directory ($cwd)."
        fi
        ;;
    NotebookEdit)
        target="$(printf '%s' "$payload" | jq -r '.tool_input.notebook_path // empty')"
        if [ -n "$target" ] && is_outside "$target"; then
            deny "Blocked: $target is outside the session directory ($cwd)."
        fi
        ;;
    Grep|Glob)
        target="$(printf '%s' "$payload" | jq -r '.tool_input.path // empty')"
        if [ -n "$target" ] && is_outside "$target"; then
            deny "Blocked: $target is outside the session directory ($cwd)."
        fi
        ;;
    Bash)
        # obsidian-cli passes symbolic names, not paths — it bypasses this scan by
        # design, as the intended entry point for the vault (see obsidian-vault skill).
        command="$(printf '%s' "$payload" | jq -r '.tool_input.command // empty')"
        [ -n "$command" ] || exit 0
        for token in $command; do
            case "$token" in
                *'://'*) continue ;;
            esac
            is_path=""
            case "$token" in
                /*|"~"*|'"'/*|"'"/*|'"~'*|"'~"*) is_path=1 ;;
                ../*|*/../*|*/..|..) is_path=1 ;;
            esac
            [ -n "$is_path" ] || continue
            clean="${token%%[\;\&\|\)]*}"
            [ -n "$clean" ] || continue
            if is_outside "$clean"; then
                deny "Blocked: command references '$clean', outside the session directory ($cwd)."
            fi
        done
        ;;
esac

exit 0
