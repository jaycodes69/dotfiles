# Check if the directory already exists, clone only if it doesn't
if [ ! -d "$HOME/.zinit" ]; then
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

# Load Zinit
source "$HOME/.zinit/bin/zinit.zsh"

### CORE PLUGINS ###
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light hlissner/zsh-autopair

### ZOXIDE ###
zinit ice from"gh-r" as"program"
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
alias cd='z'

### OPTIONAL FZF ###
# Uncomment below if you use `fzf`
zinit light junegunn/fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
