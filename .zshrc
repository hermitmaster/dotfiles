# Environment variables; vars that depend on others are near thend of the list
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
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
# The following variables depend on the ones above
export HOMEBREW_BUNDLE_FILE_GLOBAL="${XDG_CONFIG_HOME}/brewfile.rb"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"

# Setup the PATH
# homebrew; add homebrew's bin and sbin to path
PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}"
# ruby; override system version
PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:${PATH}"
# coreutils; override system binaries
PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
# findutils; override system binaries
PATH="${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin:${PATH}"
# mason; add binaries installed by mason to path
PATH="${XDG_DATA_HOME}/nvim/mason/bin:${PATH}"
# Locally built binaries
PATH="${HOME}/.local/bin:${PATH}"

export PATH

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
alias python="python3"
alias tf="terraform"
alias tg="terragrunt"
alias tree="eza -aT"
alias treed="tree -D"
alias uatt="bb && nps"

# Shell options
setopt hist_ignore_all_dups inc_append_history share_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Source files
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"
. <(zoxide init zsh --cmd cd)
. <(direnv hook zsh)

# Configure fpath and initialize completions
fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
fpath+="${HOMEBREW_PREFIX}/share/zsh-completions"
autoload -Uz compinit bashcompinit; compinit && bashcompinit

# Functions
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

function thanos_compact_status {
  kubecontext=$(kubectx -c)

  if [ ! kubecontext ]; then
    print "No cluster selected. Please set your kubecontext with 'kubectx CLUSTER_NAME' and try again.\n"
    return
  else
    printf "Checking thanos-compact status in %s\n" "$kubecontext"
  fi

  halt_logs="$(kubectl -n prometheus-operator logs thanos-compact-0 | grep halt)"

  if [[ $halt_logs ]]; then
    halt_error=""

    if [[ $(grep "no space left on device" <<< "$halt_logs") ]]; then
      halt_error="Disk is full. Please increase storage."
    elif [[ $(grep "block with not healthy index found" <<< "$halt_logs") ]]; then
      halt_error="Bad block found. Please delete the bad block and restart thanos-compact. The block id should be listed in the error below."
    elif [[ $(grep "compact command failed" <<< "$halt_logs") ]]; then
      halt_error="Compaction failed. Please check the error below. Most likely a bad block."
    else
      halt_error="Unknown error. Please check the logs below."
    fi

    printf "Thanos compact is halted. %s\n\nRelevant logs:\n%s\n" "$halt_error" "$halt_logs"
  else
    print "Thanos compact is healthy.\n"
  fi
}

# Set the window title; this should be the last thing in the file
function _set_window_title { print -Pn "\e]0;%~  ${1[0,25]:-zsh}\a" }
function precmd { _set_window_title "$@"}
function preexec { _set_window_title "$@"}

