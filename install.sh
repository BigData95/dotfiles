#!/bin/bash

echo "🚀 Bootstrapping Neovim IDE Environment..."

# 1. System Dependencies (Ripgrep, Stow, Build tools)
# python3-venv + pip are required by Mason to install the Python formatters
# (black, isort); unzip is needed to unpack several Mason packages.
echo "📦 Installing core system packages..."
sudo apt update
sudo apt install -y ripgrep stow curl git build-essential unzip python3 python3-pip python3-venv

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

# 5. Terraform (Official HashiCorp apt repository)
echo "🏗️  Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install -y terraform

# 6. AWS CLI v2
echo "☁️  Installing AWS CLI..."
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip -q -o /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install --update
rm -rf /tmp/aws /tmp/awscliv2.zip

# 7. Nerd Font (Required for lualine/trouble/lspkind icons)
echo "🔤 Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts
curl -fsSL -o /tmp/JetBrainsMono.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf /tmp/JetBrainsMono.tar.xz -C ~/.local/share/fonts
rm /tmp/JetBrainsMono.tar.xz
fc-cache -f
echo "   ⚠️  Set your terminal font to 'JetBrainsMono Nerd Font' to see icons."

# 8. GNU Stow (The Magic Symlinks)
echo "🔗 Stowing Neovim configuration..."
# This assumes you run the script from inside the dotfiles folder
stow nvim -t ~/.config/

echo "✅ Setup Complete! Please ensure your ~/.zshrc or ~/.bashrc has the following lines:"
echo 'export PATH=$PATH:/usr/local/go/bin'
echo 'export PATH=$PATH:$(go env GOPATH)/bin'
echo 'export PATH=$PATH:~/.npm-global/bin'
echo ""
echo "ℹ️  LSP servers and formatters (black, isort, prettierd, gofumpt, goimports, stylua)"
echo "   are installed automatically by Mason the first time you open nvim."
