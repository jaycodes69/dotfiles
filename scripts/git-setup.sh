#!/bin/bash
set -euo pipefail

# === Settings ===
SSH_KEY="$HOME/.ssh/id_ed25519"
YAY_DIR="/tmp/yay-bin"
NEEDED_PKGS=(git openssh base-devel)

echo "📦 Step 1: Installing required packages with pacman..."
sudo pacman -Syu --noconfirm "${NEEDED_PKGS[@]}"

# === Install yay-bin from AUR ===
if ! command -v yay &>/dev/null; then
	echo "🔧 Installing yay-bin from AUR..."
	rm -rf "$YAY_DIR"
	git clone https://aur.archlinux.org/yay-bin.git "$YAY_DIR"
	pushd "$YAY_DIR" >/dev/null
	makepkg -si --noconfirm
	popd >/dev/null
else
	echo "✅ yay is already installed."
fi

# === Install GitHub CLI ===
if ! command -v gh &>/dev/null; then
	echo "📦 Installing GitHub CLI (gh)..."
	yay -S --noconfirm github-cli
else
	echo "✅ GitHub CLI is already installed."
fi

# === Git identity configuration ===
echo "🧙 Step 2: Configuring Git identity..."
if [[ -z "$(git config --global user.name || true)" ]]; then
	read -rp "Enter your full name for Git commits: " name
	git config --global user.name "$name"
fi

if [[ -z "$(git config --global user.email || true)" ]]; then
	read -rp "Enter your email for Git commits: " email
	git config --global user.email "$email"
fi

# Default new repos to use 'main' branch
git config --global init.defaultBranch main

# Optional Git quality-of-life improvements (edit below if you like)
git config --global core.editor "nvim"
git config --global pull.rebase true
git config --global alias.st status
git config --global alias.cm commit
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.lg "log --oneline --graph --all --decorate"

# === SSH Key Generation ===
echo "🔐 Step 3: Setting up SSH key..."
if [[ ! -f "$SSH_KEY" ]]; then
	echo "No SSH key found. Generating new ed25519 key..."
	read -rp "Enter a comment for your SSH key (usually your email): " COMMENT
	ssh-keygen -t ed25519 -C "$COMMENT" -f "$SSH_KEY" -N ""
else
	echo "✅ SSH key already exists at $SSH_KEY"
fi

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# === Optional: Upload SSH Key to GitHub ===
echo "🌐 Step 4: Optionally upload SSH key to GitHub..."
if gh auth status &>/dev/null; then
	read -rp "Upload SSH key to GitHub? [y/N]: " upload
	if [[ "$upload" =~ ^[Yy]$ ]]; then
		read -rp "Name this key on GitHub (e.g. Arch Laptop): " KEY_TITLE
		gh ssh-key add "$SSH_KEY.pub" --title "$KEY_TITLE"
		echo "✅ SSH key uploaded to GitHub."
	fi
else
	echo "⚠️ You're not authenticated with GitHub CLI."
	echo "Run 'gh auth login' and re-run this script if you want to upload the key."
fi

echo -e "\n🎉 All done! You can now use Git and push via SSH to GitHub."
