export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export KUBECONFIG="$HOME/.kube/config"
export NPM_CONFIG_PREFIX="$HOME/.local"
export NPM_CONFIG_PYTHON=""
export _ZO_DOCTOR=0
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Apple Silicon and Intel install Homebrew to different prefixes. Deriving this
# matters: every PATH entry, fpath entry, and plugin `source` downstream is
# built from it, and they all fail *silently* (via (N) globs and file tests)
# when it points at a prefix that does not exist.
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
  export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
fi
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

export CLAUDE_AUTO_BACKGROUND_TASKS=1
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
export ENABLE_PROMPT_CACHING_1H=1

# NOTE: history parameters (HISTFILE/HISTSIZE/SAVEHIST) deliberately do NOT
# live here. macOS /etc/zshrc runs after .zshenv and hardcodes them, so any
# value set here is silently clobbered. They are set in .zshrc instead.

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
