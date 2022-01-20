export TF_VAR_DD_API_KEY="d466dd762d3d938030dc66ff12c5f59c"
export TF_VAR_DD_APP_KEY="58f4893bff15340157713f0c2ebd57d2806d8dc5"

export XDG_CACHE_HOME=${HOME}/.cache
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share

export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE=${XDG_CONFIG_HOME}/.Brewfile
export NPM_CONFIG_PREFIX=${HOME}/.local
export PATH=${HOME}/.local/bin:/opt/homebrew/bin:${PATH}

alias bb='brew bundle install --cleanup'
alias gaa='git add -A'
alias gb='git branch'
alias gcan!='git commit --amend --no-edit'
alias gco='git checkout'
alias gd='git difftool --no-symlinks --dir-diff'
alias gds='git difftool --no-symlinks --dir-diff --staged'
alias gfap='git fetch --all --prune'
alias glg='git log --graph'
alias gp='git push'
alias gp!='git push --force'
alias grb='rebase'
alias grba='rebase --abort'
alias grbc='rebase --continue'
alias grbi='rebase --interactive'
alias grbs='rebase --skip'
alias gst='git status'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install

setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

autoload -Uz compinit promptinit && compinit && promptinit

zstyle :prompt:pure:execution_time color 242
zstyle :prompt:pure:prompt:success color 2

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

function man {
  env \
    PAGER="less -s -MR +Gg" \
    LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
    LESS_TERMCAP_so=$(tput rev; tput setaf 4) \
    LESS_TERMCAP_us=$(tput smul; tput setaf 5) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_se=$(tput sgr0) \
    command man "${@}"
}
