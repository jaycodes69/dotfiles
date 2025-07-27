#!/bin/bash

set -e

# Change to the dotfiles directory
cd "$(dirname "$0")" || exit 1

# Define packages (folders inside ~/.dotfiles)
PACKAGES=("jay" "zsh")  # Add/remove as needed

echo "🔁 Refreshing stow packages..."

for pkg in "${PACKAGES[@]}"; do
  echo "↺ Restowing: $pkg"
  stow -D "$pkg"
  stow "$pkg"
done

echo "✅ Dotfiles stowed successfully!"
