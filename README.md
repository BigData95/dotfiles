# Ilich's Neovim IDE Dotfiles 🚀

A complete, professional Neovim IDE for **Go**, **TypeScript/JavaScript
(React)**, **Python**, **HTML/CSS**, and **Terraform/AWS** work — LSP,
formatting on save, linting, git integration, fuzzy finding, and
schema-validated YAML/JSON for cloud configs.

Built for **Neovim 0.12+** using native APIs (`vim.lsp.config`), no distro
wrappers. Deployed with **GNU Stow** symlinks, reproducible via
`lazy-lock.json` and two bootstrap scripts.

---

## ⚡ Quick start

### Linux (Debian/Ubuntu)

```sh
git clone git@github.com:BigData95/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### macOS (Apple Silicon)

```sh
git clone git@github.com:BigData95/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install-mac.sh
./install-mac.sh
```

The script installs: ripgrep, stow, build tools, Neovim, Go, Node +
tree-sitter CLI, Terraform, AWS CLI, a Nerd Font, and the Python bits Mason
needs — then symlinks `nvim/` to `~/.config/nvim`.

### After the script — 3 manual steps

1. **Add to your `~/.zshrc` or `~/.bashrc`** (the script prints these too):

   ```sh
   export PATH=$PATH:/usr/local/go/bin
   export PATH=$PATH:$(go env GOPATH)/bin
   export PATH=$PATH:~/.npm-global/bin
   ```

2. **Set your terminal's font to `JetBrainsMono Nerd Font`** — otherwise
   statusline and completion icons render as broken boxes.

3. **Open `nvim` and wait.** First launch takes a couple of minutes:
   lazy.nvim installs every plugin, treesitter compiles parsers, and Mason
   downloads all LSP servers and formatters. Restart nvim once it settles.

### Verify it worked

Inside nvim run `:checkhealth` (no red errors expected), `:Mason` (all
packages ✓), and `:Lazy` (no load errors). Then open any `.go` file, type
`fmt.Println("hi")` without the import, save — the import appears
automatically. That's the setup working.

---

## 🧰 What's inside

| Area | Tooling |
|------|---------|
| Plugin manager | lazy.nvim (versions pinned in `lazy-lock.json`) |
| LSP | gopls, ts_ls, eslint, pyright, ruff, terraform-ls, html, cssls, jsonls, yamlls, dockerls, bashls, lua_ls — all auto-installed by Mason |
| Formatting | conform.nvim, **format on save**: gofumpt+goimports (Go), prettierd (JS/TS/React/HTML/CSS/JSON/YAML/MD), ruff (Python), terraform fmt, stylua (Lua) |
| Linting | ruff LSP (Python), eslint LSP (JS/TS), staticcheck via gopls |
| Completion | nvim-cmp + LuaSnip + friendly-snippets, auto-imports on accept |
| Syntax | nvim-treesitter (`main` branch) |
| Navigation | telescope (+ fzf-native), harpoon2, netrw |
| Git | fugitive (commands) + gitsigns (inline hunks, stage/reset/blame) |
| Diagnostics UI | trouble.nvim project-wide panel |
| Cloud/AWS | schemastore.nvim → validation & completion for CloudFormation, SAM, GitHub Actions, docker-compose…; CloudFormation `!Ref`/`!GetAtt` tags whitelisted; Terraform + AWS CLI installed by script |
| UI | rose-pine theme, lualine statusline, which-key popup |
| Extras | undotree, autopairs, ts-autotag (JSX/HTML), lazydev (Lua) |

## ⌨️ Keymaps

Leader is `Space`. Press it and pause — **which-key shows every binding**.
Full reference with tables per workflow: **[nvim/KEYMAPS.md](nvim/KEYMAPS.md)**.

The three you'll use immediately: `<leader>pf` find file, `<leader>pg` live
grep, `<leader>ca` quick-fix/auto-import under cursor.

## 📂 Repository structure

```text
dotfiles/
├── install.sh              # Linux bootstrap
├── install-mac.sh          # macOS bootstrap
├── CLAUDE.md               # Conventions & verification (for AI-assisted edits)
├── README.md
└── nvim/                   # Stowed to ~/.config/nvim
    ├── init.lua            # Entry point
    ├── KEYMAPS.md          # Shortcut reference
    ├── lazy-lock.json      # Plugin lockfile
    └── lua/ilich/
        ├── init.lua        # Load order: set → remap → lazy
        ├── set.lua         # Editor options
        ├── remap.lua       # Plugin-independent keymaps
        ├── lazy.lua        # lazy.nvim bootstrap
        └── plugins/        # One plugin spec per file — drop a file in, it loads
```

## 🔧 Extending

- **New plugin**: add a file under `nvim/lua/ilich/plugins/` returning a
  lazy.nvim spec. No registration needed.
- **New language**: add the server to the `servers` list in
  `plugins/lsp.lua`, its treesitter parser to `plugins/treesitter.lua`, and
  (if it has a formatter) an entry in `plugins/conform.lua` +
  mason-tool-installer's list. Mason installs everything on next launch.
- Conventions and headless test commands live in [CLAUDE.md](CLAUDE.md).

## 🩺 Troubleshooting

| Symptom | Fix |
|---------|-----|
| Squares/boxes instead of icons | Terminal font isn't the Nerd Font (step 2 above) |
| `ruff`/`prettierd` "not found" in `:ConformInfo` | Run `:MasonToolsInstall`; on Linux ensure `python3-venv` is installed |
| Python formatting does nothing | `:ConformInfo` in the buffer shows which formatter matched and why not |
| Terraform files not formatting | `terraform` binary must be on PATH (`terraform version`) |
| No AWS resource completion in `.tf` | Run `terraform init` in the project first |
| Treesitter errors after update | `:TSUpdate`, then restart |
| Want a clean reinstall | `rm -rf ~/.local/share/nvim ~/.local/state/nvim` and reopen nvim |
