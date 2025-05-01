# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jay/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Load custom aliases from alias.sh
if [ -f "$HOME/.config/alias.sh" ]; then
    source "$HOME/.config/alias.sh"
fi

# # Load custom functions
# for f in ~/.config/functions/*.sh; do
#   source "$f"
# done

# LSD Aliases
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree'
alias l1='lsd -1'
alias ld='lsd -d */'
alias ltr='lsd -lt'
alias lsr='lsd -lr'
alias lsg='lsd -l --git'
alias ldot='lsd -a | grep "^\."'
alias ltree='lsd --tree --depth=2'
alias ldeep='lsd --tree --depth=5'
alias ltreea='lsd --tree -a'
alias lsize='lsd -l --sizesort'
alias lver='lsd -l --versionsort'
alias lext='lsd -l --extensionsort'

# env
 
export XCURSOR_THEME="Bibata-Modern-Ice"
export SWAY_CURSOR_THEME="Bibata-Modern-Ice"
export XCURSOR_SIZE=24

eval "$(starship init zsh)"
