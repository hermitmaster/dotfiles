export _ZO_DOCTOR=0
export CLAUDE_AUTO_BACKGROUND_TASKS=1
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
export ENABLE_PROMPT_CACHING_1H=1
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_PREFIX="/opt/homebrew"
export KUBECONFIG="$HOME/.kube/config"
export NPM_CONFIG_PREFIX="$HOME/.local"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
