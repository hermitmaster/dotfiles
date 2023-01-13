export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/Brewfile.rb"

test $(arch) = "arm64" && DEFAULT_HOMEBREW_PREFIX="/opt/homebrew"
. <("${DEFAULT_HOMEBREW_PREFIX:-"/usr/local"}/bin/brew" shellenv)
test -e "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install --clean

export EDITOR="nvim"
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:${PATH}"

alias bb="brew bundle install --clean"
alias btm="btm --basic"
alias kctx="kubectx"
alias kns="kubens"
alias ls="exa --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias nps="nvim --headless +'autocmd User PackerComplete qa' +'PackerSync'"
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
. "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"
. <(direnv hook zsh)

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

function _bs {
  ln -fs "${XDG_CONFIG_HOME}/.editorconfig" "${HOME}/.editorconfig"
  ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  uatt
}

function _set_window_title { print -Pn "\e]0;%~  ${1[0,25]:-zsh}\a" }
function precmd { _set_window_title "$@"}
function preexec { _set_window_title "$@"}

if [[ ${USER} != "hermitmaster" ]]; then
  . "${HOME}/.pkops/env"

  function namespace-creator {
    docker run -it \
      -v ${HOME}/.kube:/.kube \
      -v ${HOME}/work/delivery/cloud15-infra/namespace.yaml:/namespace.yaml \
      repocache.nonprod.ppops.net/dev-docker-local/cloud15callenv:1.63 \
      --namespaces-file /namespace.yaml \
      --sync "${@}"
  }
fi
