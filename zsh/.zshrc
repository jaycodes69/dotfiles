# ~/.config/zsh/.zshrc — main entry point

# Use config dir as base (makes your $HOME clean)
export ZDOTDIR="$HOME/.config/zsh"

# Load modular configs (order matters)
source "$ZDOTDIR/exports.zsh"     # environment variables, PATH
source "$ZDOTDIR/options.zsh"     # shell options, history settings
source "$ZDOTDIR/plugins.zsh"     # plugin managers, plugin init
source "$ZDOTDIR/aliases.zsh"     # custom aliases & functions
source "$ZDOTDIR/starship.zsh"    # prompt (starship) config

# Local overrides for secrets or machine-specific tweaks
[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"

# Adjust terminal settings when inside tmux
if [[ -n "$TMUX" ]]; then
  export TERM="screen-256color"   # fixes colors and keybindings inside tmux

  # Clipboard copy alias using tmux buffer (requires tmux-yank plugin)
  alias copy='tmux save-buffer - | xclip -selection clipboard'

  # (Optional) Enable tmux-aware vi-mode or keybinds here
fi

# Interactive tmux session launcher
if [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  echo -n "Start fresh [f] or restore previous session [r]? "
  read -r choice
  if [ "$choice" = "r" ]; then
    tmux new-session \; run-shell '~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh'
  else
    echo -n "Session name: "
    read -r session_name
    tmux new-session -s "${session_name:-main}"
  fi
fi
