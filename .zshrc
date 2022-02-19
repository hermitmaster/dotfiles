export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/.Brewfile"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"

alias bb='brew bundle install --clean'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

setopt hist_ignore_all_dups share_history

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -e "${HOMEBREW_BUNDLE_FILE}.lock.json" || bb

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"

autoload -Uz compinit && compinit

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -a 'k' history-substring-search-up
bindkey -a 'j' history-substring-search-down

function _nvim_packer_sync {
  rm -rf "${XDG_CONFIG_HOME}/nvim/plugin/" &>/dev/null
  nvim --headless +'autocmd User PackerComplete quitall' +'PackerSync'
}

function _bs {
  brew bundle install --clean
  _nvim_packer_sync
}

function man {
  env \
    LESS_TERMCAP_md=$(tput bold; tput setaf 1) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_so=$(tput smso; tput setaf 4) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_us=$(tput setaf 2) \
    LESS_TERMCAP_z=$(tput sgr0) \
    PAGER='less -sMRX +Gg' \
    command man "${@}"
}

