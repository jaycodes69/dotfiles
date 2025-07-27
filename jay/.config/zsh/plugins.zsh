# Fix for infinite recursion in starship vi-mode support
autoload -Uz add-zle-hook-widget

# Prevent Starship from double-wrapping `zle-keymap-select`
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select ""
fi

# Zinit installation (run this once if not already installed)
[[ ! -f ~/.zinit/bin/zinit.zsh ]] && mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin

source ~/.zinit/bin/zinit.zsh

# Plugins
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Enable vi mode
bindkey -v

# Prompt
eval "$(starship init zsh)"

# Zoxide (with j as alias)
eval "$(zoxide init zsh --cmd j)"
export _ZO_ECHO=1
