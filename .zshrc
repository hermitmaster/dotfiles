# XDG Base Directory Specification: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Homebrew config
export HOMEBREW_BUNDLE_FILE_GLOBAL="${XDG_CONFIG_HOME}/brewfile.rb"
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"

export BAT_THEME="ansi"
export CXXFLAGS="-stdlib=libc++"
export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
export EDITOR="nvim"
export KUBECONFIG="${HOME}/.kube/config"
export LDAP_USER=$USER
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export NPM_CONFIG_PYTHON=""
export PATH="${XDG_DATA_HOME}/nvim/mason/bin:${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${HOMEBREW_PREFIX}/opt/ruby/bin:${HOME}/.local/bin:${PATH}"

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
alias python="python3"
alias tf="terraform"
alias tg="terragrunt"
alias tree="eza -aT"
alias treed="tree -D"
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
. <(zoxide init zsh --cmd cd)
. <(direnv hook zsh)

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
fpath+="${HOMEBREW_PREFIX}/share/zsh-completions"
autoload -Uz compinit bashcompinit; compinit && bashcompinit

function _bs {
  ln -fs "${XDG_CONFIG_HOME}/.editorconfig" "${HOME}/.editorconfig"
  ln -fs "${XDG_CONFIG_HOME}/.prettierrc" "${HOME}/.prettierrc"
  ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  uatt
}

function pkopsenv {
  source "${PKOPS_ENV}" && pkopsenv
}

function viewcert {
  BASE_URL=$(basename ${1})
  nslookup ${BASE_URL}
  (openssl s_client -showcerts -servername ${BASE_URL} -connect ${BASE_URL}:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}

function _set_window_title { print -Pn "\e]0;%~  ${1[0,25]:-zsh}\a" }
function precmd { _set_window_title "$@"}
function preexec { _set_window_title "$@"}

