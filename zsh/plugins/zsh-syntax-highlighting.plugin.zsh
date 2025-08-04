if [[ ! -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  echo "zsh-syntax-highlighting plugin requires Homebrew's zsh-syntax-highlighting to be installed."
  return
fi

source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

