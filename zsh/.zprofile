# PATH needs to be specified here, as path_helper will reorder it if it's set
# in .zshenv
typeset -gU fpath path

path=(
  $HOME/.codeium/windsurf/bin(N)
  $HOME/.rd/bin(N)
  $XDG_DATA_HOME/nvim/mason/bin(N)
  $GOBIN(N)
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

