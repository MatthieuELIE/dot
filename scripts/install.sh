#!/usr/bin/env sh
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"
BIN_DIR="$HOME/.local/bin"
ZSHRC="$HOME/.zshrc"

ENV_START="# >>> DOTFILES ENVIRONMENT VARIABLES >>>"
ENV_END="# <<< DOTFILES ENVIRONMENT VARIABLES <<<"

generate_env_block() {
    cat <<EOF
$ENV_START

# Jira host (example: jira.mycompany.com)
# export JIRA_HOST=""

# Jira project key (example: DCHFACTUAL)
# export JIRA_PROJECT_KEY=""

# GitLab personal access token
# export GITLAB_TOKEN=""

# GitLab user ID (numeric)
# export GITLAB_USERID=""

$ENV_END
EOF
}

env_block_exists() {
    [ -f "$ZSHRC" ] && grep -q "$ENV_START" "$ZSHRC"
}

install_bins() {
    mkdir -p "$BIN_DIR"

    for script in "$SCRIPTS_DIR"/*; do
        [ -f "$script" ] || continue

        bin_name="$(head -n 20 "$script" | sed -n 's/^# bin:[[:space:]]*//p' | head -n 1)"
        [ -n "$bin_name" ] || continue

        chmod +x "$script"
        ln -sf "$script" "$BIN_DIR/$bin_name"

        echo "Installed binary: $bin_name"
    done
}

update_env_block() {
    if env_block_exists; then
        return
    fi

    echo >>"$ZSHRC"
    generate_env_block >>"$ZSHRC"
}

install_bins
update_env_block

echo "Dotfiles installation complete."
echo
echo "Ensure ~/.local/bin is in your PATH."
echo "Reload your shell or run: source ~/.zshrc"
