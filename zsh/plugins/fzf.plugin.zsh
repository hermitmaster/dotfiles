if [[ ! -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then
  echo "fzf plugin requires Homebrew's fzf to be installed."
  return
fi

source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
