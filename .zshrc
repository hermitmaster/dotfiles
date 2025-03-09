#!/usr/bin/env zsh

export BAT_THEME="ansi"
export CXXFLAGS="-stdlib=libc++"
export EDITOR="nvim"
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_PREFIX="/opt/homebrew"
export KUBECONFIG="${HOME}/.kube/config"
export LDAP_USER=$USER
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export NPM_CONFIG_PYTHON=""
export VISUAL="code"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
# The following variables depend on the ones above
export GOPATH="${XDG_DATA_HOME}/go"
export HOMEBREW_BUNDLE_FILE_GLOBAL="${XDG_CONFIG_HOME}/brewfile.rb"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
P10K_INSTANT_PROMPT_CACHE="${XDG_CACHE_HOME}/p10k-instant-prompt-${USER}.zsh"

PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}"
PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:${PATH}"
PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
PATH="${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin:${PATH}"
PATH="${XDG_DATA_HOME}/nvim/mason/bin:${PATH}"
PATH="${GOPATH}/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"

export PATH

FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:${FPATH}"
FPATH="${XDG_CONFIG_HOME}/zsh/functions:${FPATH}"
FPATH="${HOME}/work/zsh/functions:${FPATH}"

# shellcheck source="${XDG_CACHE_HOME}/p10k-instant-prompt-${USER}.zsh"
test -f "${P10K_INSTANT_PROMPT_CACHE}" && . "${P10K_INSTANT_PROMPT_CACHE}"

# Aliases
alias bb="brew bundle install --global"
alias bbm="bb && mas upgrade"
alias btm="btm --basic"
alias cat="bat"
alias kctx="kubectx"
alias kns="kubens"
alias ls="eza --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias nps="nvim --headless +'Lazy! sync' +qa"
alias pip="pip3"
alias python="python3"
alias tf="terraform"
alias tg="terragrunt"
alias tree="eza -aT"
alias treed="tree -D"
alias uatt="bb && nps"

# Shell options
setopt hist_ignore_all_dups inc_append_history share_history
HISTSIZE=100000

. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"

# shellcheck disable=SC1094
. "${XDG_CONFIG_HOME}/.p10k.zsh"

# shellcheck source="$(zoxide init zsh --cmd cd)"
. <(zoxide init zsh --cmd cd)
# shellcheck source="$(direnv hook zsh)"
. <(direnv hook zsh)
# shellcheck source="$(gh copilot alias -- zsh)"
. <(gh copilot alias -- zsh)

autoload -Uz compinit bashcompinit
compinit && bashcompinit

function _bs {
  test -L "${HOME}/.editorconfig" || ln -fs "${XDG_CONFIG_HOME}/.editorconfig" "${HOME}/.editorconfig"
  test -L "${HOME}/.prettierrc" || ln -fs "${XDG_CONFIG_HOME}/.prettierrc" "${HOME}/.prettierrc"
  test -L "${HOME}/.zshrc" || ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  uatt
}

function _set_window_title {
    local title="${1:0:25}"
    print -Pn "\e]0;%~  ${title:-zsh}\a"
}

function precmd {
  _set_window_title "$@"
}

function preexec {
  _set_window_title "$@"
}
