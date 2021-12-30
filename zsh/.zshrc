alias bb='brew bundle install --cleanup'
alias gs='lazygit'
alias tf='terraform'
alias tg='terragrunt'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history

autoload -Uz compinit
compinit -d "${HOME}/.zcompdump"

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/antigen/antigen.zsh"
antigen init "${ZDOTDIR}/.antigenrc"

