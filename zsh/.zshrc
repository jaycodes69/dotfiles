# ~/.config/zsh/.zshrc (main entry)

# Use config directory as base for all Zsh configs
export ZDOTDIR="$HOME/.config/zsh"

# Source each modular component
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/starship.zsh"

# Load local overrides (e.g., secrets or machine-specific config)
[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"

# Autostart tmux and prompt user
if [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  echo -n "Start fresh [f] or restore previous session [r]? "
  read -r choice
  if [ "$choice" = "r" ]; then
    tmux new-session \; run-shell '~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
  else
    echo -n "Session name: "
    read -r session_name
    tmux new-session -s "${session_name:-main}"
  fi
fi
