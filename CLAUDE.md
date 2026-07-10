# Dotfiles

Personal dotfiles managed with GNU Stow. Currently contains a Neovim IDE
configuration for Go, TypeScript/JavaScript (React), Python, HTML/CSS, and
Terraform.

## Layout

```
install.sh          Bootstrap script for Ubuntu/Debian (apt)
install-mac.sh      Bootstrap script for macOS (Homebrew, Apple Silicon)
nvim/               Neovim config — stowed to ~/.config/nvim
  init.lua          Entry point: requires lua/ilich
  KEYMAPS.md        Keyboard shortcut reference
  lua/ilich/
    init.lua        Load order: set → remap → lazy (options before plugins)
    set.lua         Editor options (vim.opt)
    remap.lua       Plugin-independent keymaps
    lazy.lua        lazy.nvim bootstrap; imports every file in plugins/
    plugins/        One lazy.nvim plugin spec per file
```

## Conventions

- **Adding a plugin**: create a new file in `nvim/lua/ilich/plugins/` that
  returns a lazy.nvim spec. It is picked up automatically — nothing to
  register. Lazy-load where possible (`event`, `ft`, `cmd`, `keys`).
- **Every keymap gets a `desc`** — which-key displays them.
- **LSP servers** live in the `servers` list in `plugins/lsp.lua` (and
  `default_servers` if they need no custom settings). Mason installs them
  automatically via mason-lspconfig `ensure_installed`.
- **Formatters** run through conform.nvim (`plugins/conform.lua`),
  format-on-save enabled. Binaries are auto-installed by
  mason-tool-installer — add new ones to its `ensure_installed` list.
  Python uses ruff (not black/isort). Formatting keymap `<leader>f` is
  owned by conform; do not add LSP `vim.lsp.buf.format` mappings or
  BufWritePre format autocmds elsewhere (double-formatting).
- **jsonls/yamlls get their schemas from schemastore.nvim** (configured in
  `plugins/lsp.lua`, not in `default_servers`). yamlls also whitelists
  CloudFormation intrinsic tags (`!Ref`, `!GetAtt`, …) via `customTags`.
- **Treesitter uses the `main` branch** (new API: `install()` +
  `vim.treesitter.start()`), not the legacy `master` `ensure_installed`
  config style.

## Requirements / gotchas

- Neovim 0.12+ (config uses `vim.lsp.config` / `vim.lsp.enable`).
- Mason needs `python3-venv` (Linux) to install ruff; `unzip` for several
  packages. Both are handled by the install scripts.
- `terraform_fmt` needs the `terraform` binary on PATH (install scripts
  handle it).
- Icons (lualine, trouble, lspkind) need a Nerd Font in the terminal —
  scripts install JetBrainsMono Nerd Font, but the terminal emulator must
  be set to use it manually.

## Verifying changes

```sh
# Config loads without errors + plugins install
nvim --headless "+Lazy! sync" +qa

# Install any new Mason tools
nvim --headless -c "MasonToolsInstallSync" -c "qa"

# Exercise format-on-save on a scratch file
nvim --headless /tmp/test.py -c "w" -c "qa" && cat /tmp/test.py
```

Keymap documentation lives in `nvim/KEYMAPS.md` — update it when adding or
changing mappings.
