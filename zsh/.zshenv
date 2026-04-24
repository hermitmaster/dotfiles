export CXXFLAGS="-stdlib=libc++"
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_PREFIX="/opt/homebrew"
export KUBECONFIG="$HOME/.kube/config"
export NPM_CONFIG_PREFIX="$HOME/.local"
export NPM_CONFIG_PYTHON=""
export SAVEHIST="100000"
export _ZO_DOCTOR=0
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"

export CLAUDE_AUTO_BACKGROUND_TASKS=1
export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1
export ENABLE_PROMPT_CACHING_1H=1

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
