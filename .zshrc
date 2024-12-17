export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brewfile.rb"

test $(arch) = "arm64" && DEFAULT_HOMEBREW_PREFIX="/opt/homebrew"
. <("${DEFAULT_HOMEBREW_PREFIX:-"/usr/local"}/bin/brew" shellenv)
test -e "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install --clean

export BAT_THEME="ansi"
export CXXFLAGS="-stdlib=libc++"
export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
export EDITOR="nvim"
export KUBECONFIG="${HOME}/.kube/config"
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export NPM_CONFIG_PYTHON=""
export PATH="${XDG_DATA_HOME}/nvim/mason/bin/:${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${HOMEBREW_PREFIX}/opt/node@18/bin:${HOMEBREW_PREFIX}/opt/ruby/bin:${HOME}/.local/bin:${PATH}"

alias bb="brew bundle install --clean && mas upgrade"
alias btm="btm --basic"
alias cat="bat"
alias kctx="kubectx"
alias kns="kubens"
alias ls="eza --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias nps="nvim --headless +'Lazy! sync' +qa"
alias python="${HOMEBREW_PREFIX}/bin/python3"
alias tf="terraform"
alias tg="terragrunt"
alias tree="eza --tree"
alias uatt="update_deps && nps"

setopt hist_ignore_all_dups inc_append_history share_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. <(direnv hook zsh)

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
autoload -Uz compinit bashcompinit promptinit
compinit && bashcompinit && promptinit

zstyle :prompt:pure:execution_time color 8
zstyle :prompt:pure:git:action color 1
zstyle :prompt:pure:git:branch color 2
zstyle :prompt:pure:git:dirty color 5
zstyle :prompt:pure:host color 8
zstyle :prompt:pure:prompt:success color 2
zstyle :prompt:pure:prompt:continuation color 8
zstyle :prompt:pure:user color 8
zstyle :prompt:pure:virtualenv color 8

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

test ${USER} = "hermitmaster" || source "${HOME}/.pkops/env"

function _bs {
  ln -fs "${XDG_CONFIG_HOME}/.editorconfig" "${HOME}/.editorconfig"
  ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  uatt
}

function update_deps {
  brew update -v
  brew upgrade
  brew cleanup
  brew bundle install --clean
  mas upgrade
}

function viewcert {
  BASE_URL=$(basename ${1})
  nslookup ${BASE_URL}
  (openssl s_client -showcerts -servername ${BASE_URL} -connect ${BASE_URL}:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}

function _set_window_title { print -Pn "\e]0;%~  ${1[0,25]:-zsh}\a" }
function precmd { _set_window_title "$@"}
function preexec { _set_window_title "$@"}

