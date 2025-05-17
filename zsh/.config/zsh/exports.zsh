# Set environment variables, paths, and language settings

export XDG_CURRENT_DESKTOP=generic
export KITTY_ENABLE_SYSTEMD_SCOPE=0
export PATH="/usr/bin:$PATH"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Editors
export EDITOR="nvim"
export VISUAL="nvim"

# Pager
export PAGER="less"

# Path additions
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/yt/bin:$PATH"

# Custom Starship config path (if you use one)
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

