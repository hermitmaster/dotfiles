if (( ! $+commands[brew] )); then
  autoload -Uz bootstrap && bootstrap
fi

# Aliases
alias ll="ls -al"
alias la="ls -abghilmu"
alias treed="tree -D"

autoload -Uz $XDG_CONFIG_HOME/zsh/functions/*(:t) compinit
compinit

# Load plugins
PLUGIN_DIR="$XDG_CONFIG_HOME/zsh/plugins"
for plugin in "$PLUGIN_DIR"/*.plugin.zsh; do
  source "$plugin"
done

# Load external tools
eval "$(ssh-agent -s)" >/dev/null
eval "$(zoxide init zsh --cmd cd)"
eval "$(direnv hook zsh)"

# Shell options
## History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
## Completion
setopt always_to_end
setopt correct
setopt complete_in_word
## Other
setopt auto_pushd
setopt cd_silent
setopt pushd_ignore_dups
setopt pushd_silent
setopt auto_list
setopt auto_menu

HISTSIZE=$SAVEHIST

precmd_functions+=set_window_title
preexec_functions+=set_window_title
