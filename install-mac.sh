#!/bin/bash

echo "🚀 Bootstrapping Neovim IDE Environment for macOS..."

# 1. Homebrew (The macOS Package Manager)
if ! command -v brew &> /dev/null; then
    echo "🍺 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Ensure brew is in PATH for the rest of the script
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. System Dependencies (Ripgrep, Stow, Build tools)
echo "📦 Installing core system packages..."
brew install ripgrep stow curl git make

# 3. Neovim (Pre-compiled macOS ARM64 binary)
# Note: macOS does not support AppImages. We use the tarball release.
echo "💻 Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz
sudo rm -rf /opt/nvim-macos-arm64
sudo tar -C /opt -xzf nvim-macos-arm64.tar.gz
sudo ln -sf /opt/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
# IMPORTANT: Clear the Apple quarantine flag so it actually runs
sudo xattr -c /opt/nvim-macos-arm64/bin/nvim
rm nvim-macos-arm64.tar.gz

# 4. Go Toolchain (Apple Silicon version)
echo "🐹 Installing Go..."
GO_VERSION="1.26.0"
curl -LO https://go.dev/dl/go${GO_VERSION}.darwin-arm64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go${GO_VERSION}.darwin-arm64.tar.gz
rm go${GO_VERSION}.darwin-arm64.tar.gz

# 5. Node & Tree-sitter (With permissions fix)
echo "🌳 Installing Node & Tree-sitter CLI..."
brew install node
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
npm install -g tree-sitter-cli

# 6. GNU Stow (The Magic Symlinks)
echo "🔗 Stowing Neovim configuration..."
# This assumes you run the script from inside the dotfiles folder
stow nvim -t ~/.config/

echo "✅ Setup Complete! Please ensure your ~/.zshrc has the following lines:"
echo 'export PATH=$PATH:/usr/local/go/bin'
echo 'export PATH=$PATH:$(go env GOPATH)/bin'
echo 'export PATH=$PATH:~/.npm-global/bin'
