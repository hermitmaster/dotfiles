export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brewfile.rb"

test $(arch) = "arm64" && DEFAULT_HOMEBREW_PREFIX="/opt/homebrew"
. <("${DEFAULT_HOMEBREW_PREFIX:-"/usr/local"}/bin/brew" shellenv)
test -e "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install --clean

export BAT_THEME="ansi"
export EDITOR="nvim"
export KUBECONFIG="${HOME}/.kube/config"
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOMEBREW_PREFIX}/opt/node@18/bin:${HOMEBREW_PREFIX}/opt/ruby/bin:${HOME}/.local/bin:${PATH}"

alias bb="brew bundle install --clean"
alias cat="bat"
alias kctx="kubectx"
alias kns="kubens"
alias ls="exa --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias nps="nvim --headless +'Lazy! sync' +qa"
alias tf="terraform"
alias tg="terragrunt"
alias tree="exa --tree"
alias uatt="bb && nps"

setopt hist_ignore_all_dups inc_append_history share_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"
. <(direnv hook zsh)

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

function _bs {
  ln -fs "${XDG_CONFIG_HOME}/.editorconfig" "${HOME}/.editorconfig"
  ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  uatt

  podman machine inspect podman-machine-default || podman machine init --rootful --now --cpus=2 --memory=8192 podman-machine-default
}

function _set_window_title { print -Pn "\e]0;%~  ${1[0,25]:-zsh}\a" }
function precmd { _set_window_title "$@"}
function preexec { _set_window_title "$@"}

(test ${USER} != "hermitmaster" && . "${HOME}/.pkops/env") || return 0
