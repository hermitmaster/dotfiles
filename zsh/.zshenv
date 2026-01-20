export CXXFLAGS="-stdlib=libc++"
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_PREFIX="/opt/homebrew"
export KUBECONFIG="$HOME/.kube/config"
export NPM_CONFIG_PREFIX="$HOME/.local"
export NPM_CONFIG_PYTHON=""
export SAVEHIST="100000"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$XDG_DATA_HOME/go"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"


typeset -gU fpath path
path=(
  $HOME/.codeium/windsurf/bin(N)
  $HOME/.rd/bin(N)
  $XDG_DATA_HOME/nvim/mason/bin(N)
  $GOPATH/bin(N)
  $HOME/.local/bin(N)
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/bin(N)
  $HOMEBREW_PREFIX/sbin(N)
  $path
)

fpath=(
  $XDG_CONFIG_HOME/zsh/functions(N)
  $HOMEBREW_PREFIX/share/zsh/site-functions(N)
  $HOMEBREW_PREFIX/share/zsh-completions(N)
  $fpath
)
