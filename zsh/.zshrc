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
setopt pushd_ignore_dups auto_cd auto_pushd

autoload -Uz compinit
compinit -d "${HOME}/.zcompdump"

. <(brew shellenv)
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

