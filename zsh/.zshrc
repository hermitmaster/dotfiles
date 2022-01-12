alias bb='brew bundle install --cleanup'
alias ls='exa --git --group-directories-first'
alias l='ls -blF'
alias ll='ls -al'
alias la='ls -abghilmu'
alias tf='terraform'
alias tg='terragrunt'
alias tree='exa --tree'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history

autoload -Uz compinit && compinit -d "${HOME}/.zcompdump"

. <(brew shellenv)
. <(starship init zsh)
. <(zoxide init zsh --cmd cd)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

