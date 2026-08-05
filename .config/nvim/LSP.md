# LSP Binaries

Install and update commands for each language server configured in [`plugin/lsp.lua`](./plugin/lsp.lua).
Update this file whenever a server is added, removed, or its install method changes.

## lua_ls — lua-language-server

- Install: `brew install lua-language-server`
- Update: `brew upgrade lua-language-server`

## rust_analyzer — rust-analyzer

- Install: `rustup component add rust-analyzer`
- Update: `rustup update stable`
- Note: rust-analyzer is tied to the active rustup toolchain, it has no independent update command. `rustup check` shows if a newer stable is available.

## vue_ls — @vue/language-server

- Install: `npm install -g @vue/language-server @vue/typescript-plugin`
- Update: `npm update -g @vue/language-server @vue/typescript-plugin`

## ts_ls — typescript-language-server

- Install: `npm install -g typescript typescript-language-server`
- Update: `npm update -g typescript typescript-language-server`
- Note: if this was installed against a different Node than your active `npm` (e.g. Homebrew's Node vs fnm/nvm), point at that npm explicitly, e.g. `/opt/homebrew/bin/npm update -g typescript-language-server`.

## cssls — vscode-langservers-extracted

- Install: `npm install -g vscode-langservers-extracted`
- Update: `npm update -g vscode-langservers-extracted`

## jdtls — Eclipse JDT Language Server

- Install: `brew install jdtls`
- Update: `brew upgrade jdtls`

## Checking current vs latest

- brew: `brew list --versions <formula>` (current) vs `brew info <formula>` (latest available)
- npm: `npm ls -g <package>` (current) vs `npm view <package> version` (latest on registry)
- rust-analyzer: `rust-analyzer --version` (current) vs `rustup check` (latest stable)
