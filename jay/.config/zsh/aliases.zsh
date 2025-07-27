# Editor
alias v='nvim'
alias editz='nvim ~/.config/zsh'
alias sorce='source ~/.zshrc'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias cl='clear'

# Jumping
alias jj='j -'       # jump to previous dir
alias ji='zoxide query --interactive'

# File
alias l='eza -lh --icons'
alias la='eza -lha --icons'
alias lt='eza --tree --icons'

# Find / Search
alias f='fd'
alias ff='fd -t f'
alias fd='fd --hidden --exclude .git'
alias rg='rg --smart-case --hidden --glob "!.git/*"'

# Git
alias lg='lazygit'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Fun
alias please='sudo'
alias fuck='sudo $(fc -ln -1)'
