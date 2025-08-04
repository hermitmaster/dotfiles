if ((! $+commands[nvim] )); then
  echo "Neovim is not installed. Please install it to use this plugin."
  return
fi

export EDITOR="nvim"
export MANPAGER="nvim +Man! +'set ch=0'"
path=(
  $XDG_DATA_HOME/nvim/mason/bin(N)
  $path
)
