# Dotfiles

A collection of configuration files for macOS, focused on performance and aesthetics.

## Components

### [Neovim](.config/nvim)
- **Editor**: Modern Neovim setup in Lua.
- **Features**: LSP, Tree-sitter, Fuzzy Finding, and structured plugin management.
- **Theme**: Catppuccin.

### [Ghostty](.config/ghostty)
- **Terminal**: Fast, native renderer with a minimal configuration.
- **Config**: Custom fonts and theme integration.

### [Wezterm](.config/wezterm)
- **Terminal**: GPU-accelerated terminal emulator.
- **Features**: Advanced keybindings and custom background image support.

### [Claude Code](.claude)
- **Hooks**: commit message format, PR body format, main-branch protection.
- **Skills**: code-review, collaboration-mode, ship.

## Installation

### Prerequisites

Ensure you have [Homebrew](https://brew.sh/) and [GNU Stow](https://www.gnu.org/software/stow/) installed (`brew install stow`).

### Setup

Clone the repository and create symlinks for the configurations:

```bash
git clone https://github.com/matthieuelie/dotfiles.git ~/dot
mkdir -p ~/.config

ln -s ~/dot/.config/nvim ~/.config/nvim
ln -s ~/dot/.config/ghostty ~/.config/ghostty
ln -s ~/dot/.config/wezterm ~/.config/wezterm
```

`.claude` is managed with `stow` instead, since `~/.claude` also holds
Claude Code's own runtime state (sessions, cache, history) that must stay
local and never get symlinked in:

```bash
stow -d ~/dot -t ~/.claude .claude
```

If any target file already exists as a real file (not a symlink) with the
same relative path, `stow` refuses and lists the conflicts - move those
files aside before retrying.

## Structure

```text
.
├── .claude
│   ├── hooks/      # Bash scripts driving PreToolUse/SessionStart hooks
│   ├── skills/     # Slash-command skills
│   └── settings.json
├── .config
│   ├── ghostty/    # Terminal configuration
│   ├── nvim/       # Neovim IDE-like setup
│   └── wezterm/    # Alternative GPU terminal
└── README.md
```
