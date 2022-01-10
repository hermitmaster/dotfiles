export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/.Brewfile"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"

alias bb='brew bundle install --cleanup'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

test -L "${HOME}/.zshrc" || ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || bb

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history

autoload -Uz compinit && compinit -d "${HOME}/.zcompdump"

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"

if [[ -z $TMUX && -z $VIM ]]; then
  tmux attach 2>/dev/null || exec tmux
fi

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

