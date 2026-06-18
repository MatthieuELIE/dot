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

## Installation

### Prerequisites

Ensure you have [Homebrew](https://brew.sh/) installed.

### Setup

Clone the repository and create symlinks for the configurations:

```bash
git clone https://github.com/matthieuelie/dotfiles.git ~/dot
mkdir -p ~/.config

ln -s ~/dot/.config/nvim ~/.config/nvim
ln -s ~/dot/.config/ghostty ~/.config/ghostty
ln -s ~/dot/.config/wezterm ~/.config/wezterm
```

## Structure

```text
.
├── .config
│   ├── ghostty/    # Terminal configuration
│   ├── nvim/       # Neovim IDE-like setup
│   └── wezterm/    # Alternative GPU terminal
└── README.md
```
