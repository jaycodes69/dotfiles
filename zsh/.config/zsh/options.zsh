# Set sane Zsh options for usability, history, and behavior.

# Enable automatic directory switching: `projects` is treated like `cd projects`
setopt autocd

# Auto-correct minor command typos (e.g. `grpe` -> `grep`)
setopt correct

# Disable terminal bell
setopt no_beep

# Allow comments in interactive shell
setopt interactive_comments

# Include dotfiles in glob patterns like `*`
setopt globdots

# Avoid errors when a glob doesn’t match anything (e.g., `rm *.bak`)
unsetopt nomatch

# Append to history file, don’t overwrite it
setopt append_history

# Ignore duplicate entries in history
setopt hist_ignore_dups

# Share history between terminal sessions
setopt share_history

# Configure shell history behavior
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Completion system
autoload -Uz compinit && compinit -u

# Enable menu selection for tab completions
zstyle ':completion:*' menu select

# Case-insensitive tab completion (foo == Foo)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
