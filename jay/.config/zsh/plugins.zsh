# Zinit installation (run this once if not already installed)
[[ ! -f ~/.zinit/bin/zinit.zsh ]] && mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin

source ~/.zinit/bin/zinit.zsh

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd j)"
export _ZO_ECHO=1
