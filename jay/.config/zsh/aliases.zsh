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
alias chx='chmod +x'



alias t='tmux new-session -A -s main'

alias tn='tmux new-session -s'     

alias tl='tmux ls'

alias ta='tmux attach-session -t $(tmux ls | fzf | cut -d: -f1)'

alias tks='tmux kill-session -t $(tmux ls | fzf | cut -d: -f1)'

alias tf='tmux kill-server'

# Rename current session
alias tr='tmux rename-session'

# Save tmux layout (via resurrect if enabled)
alias tsave='tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/save.sh'

# Restore layout (if resurrect is used)
alias tres='tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'


alias ya='yay'
alias ys='yay -S'         # install
alias yr='yay -Rns'       # remove
alias yu='yay -Syu'       # update system
alias ycl='yay -Sc'       # clean cache
alias yorph='yay -Rns $(pacman -Qtdq)'  # remove orphans
