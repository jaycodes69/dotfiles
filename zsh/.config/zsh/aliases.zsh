# Aliases for easier commands and consistent behavior

### FILE LISTING (eza --icons -based) ###
alias ls='eza --icons '                        # Use `eza --icons ` instead of `ls`
alias ll='eza --icons  -lah'                   # Long list, all files, human-readable
alias la='eza --icons  -a'                     # All files, including dotfiles
alias lt='eza --icons  --tree --level=2'       # Tree view
alias lsg='eza --icons  -l --git'              # Git-aware long list

### GIT SHORTCUTS ###
alias gs='git status'
alias gl='git pull'
alias gp='git push'
alias ga='git add .'
alias gc='git commit -m'

### NAVIGATION ###
alias ..='cd ..'
alias ...='cd ../..'
alias cz='zoxide cd'   # Use zoxide directly

### MISC ###
alias grep='grep --color=auto'
alias cl='clear'

alias v='nvim'
alias so='source ~/.zshrc '

# Tmux session management
alias ts='tmux ls'                        # List all sessions
alias ta='tmux attach -t'                # Attach to session (usage: ta <session_name>)
alias tns='tmux new -s'                   # New session (usage: tns <session_name>)
alias trm='tmux kill-session -t'         # Kill session (usage: trm <session_name>)

# Tmux window management
alias tw='tmux new-window'                # Create new window
alias twl='tmux list-windows'             # List windows in current session
alias twn='tmux next-window'               # Next window
alias twp='tmux previous-window'           # Previous window
alias twk='tmux kill-window'               # Kill current window

# Tmux pane management
alias tpv='tmux split-window -v'           # Split pane vertically
alias tph='tmux split-window -h'           # Split pane horizontally
alias tpc='tmux kill-pane'                  # Kill current pane
alias tpn='tmux select-pane -t :.+'         # Select next pane
alias tpp='tmux select-pane -t :.−'         # Select previous pane

# Tmux copy & paste (assuming tmux-yank plugin or system clipboard setup)
alias tcopy='tmux save-buffer - | xclip -selection clipboard'   # Copy tmux buffer to clipboard
alias tpaste='xclip -o -selection clipboard | tmux load-buffer - \; paste-buffer'

# Session save & restore (tmux-resurrect)
alias tsave='tmux save-buffer'             # Save current buffer
alias tres='tmux source ~/.tmux/resurrect/last'  # Restore last session (adjust path if needed)

# Misc
alias tk='tmux kill-server'                 # Kill entire tmux server
alias trs='tmux source-file ~/.tmux.conf'  # Reload tmux config file
