# Ilich's Neovim IDE Dotfiles 🚀

This repository contains my professional Neovim configuration, heavily optimized for backend microservice development in **Go** and **Python**. 

Built for **Neovim 0.12.2+**, this setup avoids "magic wrappers" and distro-bloat. It uses native Neovim APIs (`vim.lsp.config`) and relies on **GNU Stow** for zero-friction, symlink-based deployment across all my machines.

## 🧠 Core Architecture

* **Plugin Manager:** `lazy.nvim` (Locked for stability via `lazy-lock.json`)
* **LSP & Intelligence:** Native `nvim-lspconfig` + `mason.nvim` (gopls, pyright, lua_ls)
* **Autocompletion:** `nvim-cmp` + `LuaSnip`
* **Navigation:** `telescope.nvim` + `harpoon` (ThePrimeagen workflow)
* **Syntax Highlighting:** `nvim-treesitter`

---

## 📂 Repository Structure

The configuration is built to be modular. GNU Stow reads the `nvim` folder and creates symlinks directly into `~/.config/nvim/`.

```text
dotfiles/
├── nvim/                   # Stow target directory
│   ├── init.lua            # Entry point
│   ├── lazy-lock.json      # Dependency lockfile
│   └── lua/
│       └── ilich/          
│           ├── remap.lua   # Core keybindings
│           ├── set.lua     # Core vim options
│           └── plugins/    # Modular plugin configs (lsp, cmp, telescope)
├── install.sh              # Linux bootstrap script
├── install-mac.sh          # macOS Apple Silicon bootstrap script
└── README.md

Usage Linux(Debian/Ubuntu)
git clone [https://github.com/YOUR_GITHUB/dotfiles.git](https://github.com/YOUR_GITHUB/dotfiles.git) ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

macOs
git clone [https://github.com/YOUR_GITHUB/dotfiles.git](https://github.com/YOUR_GITHUB/dotfiles.git) ~/dotfiles
cd ~/dotfiles
chmod +x install-mac.sh
./install-mac.sh
