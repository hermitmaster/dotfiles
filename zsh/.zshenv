export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export KUBECONFIG="$HOME/.kube/config"
export NPM_CONFIG_PREFIX="$HOME/.local"
export _ZO_DOCTOR=0
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Apple Silicon only, so the Homebrew prefix is fixed at /opt/homebrew. Every
# PATH entry, fpath entry, and plugin `source` downstream is built from it, and
# they all fail *silently* (via (N) globs and file tests) if it ever points at a
# prefix that does not exist.
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

export CLAUDE_AUTO_BACKGROUND_TASKS=1
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
export ENABLE_PROMPT_CACHING_1H=1

# NOTE: history parameters (HISTFILE/HISTSIZE/SAVEHIST) deliberately do NOT
# live here. macOS /etc/zshrc runs after .zshenv and hardcodes them, so any
# value set here is silently clobbered. They are set in .zshrc instead.

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
