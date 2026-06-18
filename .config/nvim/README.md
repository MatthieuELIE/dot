# Neovim Configuration

A concise and performance-oriented Neovim configuration.

## Prerequisites

```bash
brew install ripgrep fd lua-language-server rust-analyzer stylua
```

```bash
npm install -g typescript typescript-language-server @vue/language-server vscode-langservers-extracted
```

```bash
rustup component add rustfmt
```

## Plugins

- [**catppuccin**](https://github.com/catppuccin/nvim) — Soothing pastel theme
- [**lualine.nvim**](https://github.com/nvim-lualine/lualine.nvim) — Fast and easy to configure statusline
- [**conform.nvim**](https://github.com/stevearc/conform.nvim) — Lightweight formatter plugin
- [**oil.nvim**](https://github.com/stevearc/oil.nvim) — Edit your file system like a normal buffer
- [**mini.diff**](https://github.com/nvim-mini/mini.diff) — Visualize and work with diff hunks
- [**mini.icons**](https://github.com/nvim-mini/mini.icons) — Icon provider for Neovim
- [**mini.pairs**](https://github.com/nvim-mini/mini.pairs) — Autopairs for characters
- [**mini.surround**](https://github.com/nvim-mini/mini.surround) — Surround actions (add, delete, replace)
- [**telescope.nvim**](https://github.com/nvim-telescope/telescope.nvim) — Highly extendable fuzzy finder
- [**telescope-fzf-native.nvim**](https://github.com/nvim-telescope/telescope-fzf-native.nvim) — FZF sorter for telescope
- [**plenary.nvim**](https://github.com/nvim-lua/plenary.nvim) — Lua functions library
- [**nvim-cmp**](https://github.com/hrsh7th/nvim-cmp) — Autocompletion engine
- [**cmp-nvim-lsp**](https://github.com/hrsh7th/cmp-nvim-lsp) — LSP source for nvim-cmp
- [**bufferline.nvim**](https://github.com/akinsho/bufferline.nvim) — Snazzy tabline
- [**fidget.nvim**](https://github.com/j-hui/fidget.nvim) — LSP progress notifications

## Keymaps

### LSP

- `gd` — Go to definition
- `gD` — Go to declaration
- `gi` — Go to implementation
- `gr` — Go to references
- `<leader>k` — Hover documentation
- `gs` — Signature help
- `<leader>rn` — Rename symbol
- `<leader>ca` — Code action

### Diagnostics

- `<leader>d` — Open diagnostic float
- `<leader>q` — Diagnostics to loclist
- `[d` — Previous diagnostic
- `]d` — Next diagnostic

### Buffers

- `<Tab>` — Next buffer
- `<S-Tab>` — Previous buffer
- `<leader>bo` — Close all other buffers
- `<C-w>` — Delete current buffer

### Telescope

- `<leader>ff` — Find files
- `<leader>fg` — Live grep
- See [Telescope default mappings](https://github.com/nvim-telescope/telescope.nvim#default-mappings) for more.

### Oil

- `-` — Open parent directory
- `<CR>` — Open file or directory
- `<C-p>` — Preview file
- `<C-c>` — Close oil
- See [Oil keymaps documentation](https://github.com/stevearc/oil.nvim#keymaps) for all available actions.

### General

- `J` — Move down faster (12 lines)
- `K` — Move up faster (12 lines)
- `H` — Go to first non-blank character
- `L` — Go to end of line
- `n` — Next search result (centered)
- `N` — Previous search result (centered)
- `jj/jk/kk/kj` — Exit insert mode
- `<C-s>` — Save file
- `<C-h>` — Go to left window
- `<C-j>` — Go to lower window
- `<C-k>` — Go to upper window
- `<C-l>` — Go to right window
- `<A-j>` — Move line or selection down
- `<A-k>` — Move line or selection up
- `p` — Paste without overwriting register (visual mode)
- `x` — Delete character without yanking
