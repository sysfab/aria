setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

#
# ALIASES
#
alias cat='bat'
alias catp='bat --plain'

alias ls='eza --long --color=always --no-user --no-permissions'

alias code='zeditor'

#
# HIGHLIGHING
#
typeset -A ZSH_HIGHLIGHT_STYLES

# Base
ZSH_HIGHLIGHT_STYLES[default]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#d8dee9'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#bac2de'

# Arguments & paths
ZSH_HIGHLIGHT_STYLES[path]='fg=#b4befe'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#9399b2'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#f5c2e7'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fab387,bold'

# Strings & quotes
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#f38ba8'

# Variables
ZSH_HIGHLIGHT_STYLES[assign]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[assignment]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[dollar-single-quoted-argument]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[dollar-argument]='fg=#89b4fa'

# Numbers
ZSH_HIGHLIGHT_STYLES[math]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#f5c2e7'

# History
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#f38ba8,bold'

# Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6c7086,italic'

# Brackets
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#94e2d5'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#f5c2e7'

# Errors
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#f38ba8'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#f38ba8'
