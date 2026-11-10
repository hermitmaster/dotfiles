# Sourced from .zshenv so non-login shells (scheduler, agent tool shells) get it,
# and again from .zprofile because /etc/zprofile's path_helper moves the system
# dirs back to the front in login shells. typeset -U drops the duplicates.
typeset -gU fpath path

path=(
  $HOME/.rd/bin(N)
  $XDG_DATA_HOME/nvim/mason/bin(N)
  $GOBIN(N)
  $HOME/.local/bin(N)
  $HOME/projects/alice/bin(N)
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/openjdk@21/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/bin(N)
  $HOMEBREW_PREFIX/sbin(N)
  $path
)

fpath=(
  $XDG_CONFIG_HOME/zsh/functions(N)
  $XDG_CACHE_HOME/zsh/completions(N)
  $HOMEBREW_PREFIX/share/zsh/site-functions(N)
  $HOMEBREW_PREFIX/share/zsh-completions(N)
  $fpath
)
