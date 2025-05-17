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
