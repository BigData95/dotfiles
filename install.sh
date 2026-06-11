#!/bin/bash

echo "🚀 Bootstrapping Neovim IDE Environment..."

# 1. System Dependencies (Ripgrep, Stow, Build tools)
echo "📦 Installing core system packages..."
sudo apt update
sudo apt install -y ripgrep stow curl git build-essential

# 2. Neovim 0.12.2 AppImage
echo "💻 Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Go Toolchain (For gopls)
echo "🐹 Installing Go..."
GO_VERSION="1.26.0"
curl -LO https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz

# 4. Node & Tree-sitter (With permissions fix)
echo "🌳 Installing Node & Tree-sitter CLI..."
sudo apt install -y nodejs npm
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
npm install -g tree-sitter-cli

# 5. GNU Stow (The Magic Symlinks)
echo "🔗 Stowing Neovim configuration..."
# This assumes you run the script from inside the dotfiles folder
stow nvim -t ~/.config/

echo "✅ Setup Complete! Please ensure your ~/.zshrc or ~/.bashrc has the following lines:"
echo 'export PATH=$PATH:/usr/local/go/bin'
echo 'export PATH=$PATH:$(go env GOPATH)/bin'
echo 'export PATH=$PATH:~/.npm-global/bin'
