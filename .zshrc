setopt hist_ignore_all_dups share_history

export HOMEBREW_BUNDLE_FILE="${HOME}/.config/.Brewfile"
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"

. <(brew shellenv)
test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install

alias bb='brew bundle install --cleanup'
alias ls='exa --git --group-directories-first'
alias l='ls -blF'
alias ll='ls -al'
alias la='ls -abghilmu'
alias tf='terraform'
alias tg='terragrunt'
alias tree='exa --tree'

. <(starship init zsh)
. <(zoxide init zsh --cmd cd)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

function man {
  env \
    LESS_TERMCAP_md=$(tput bold; tput setaf 1) \
    LESS_TERMCAP_so=$(tput rev; tput setaf 4) \
    LESS_TERMCAP_us=$(tput smul; tput setaf 5) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_se=$(tput sgr0) \
    PAGER="less -s -MR +Gg" \
    command man "${@}"
}

autoload -Uz compinit && compinit

