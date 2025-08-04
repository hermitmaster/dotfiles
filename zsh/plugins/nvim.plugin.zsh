if (($+commands[nvim])); then
  export EDITOR="nvim"
  export MANPAGER="nvim +Man! +'set ch=0'"
  path=(
    $XDG_DATA_HOME/nvim/mason/bin(N)
    $path
  )
fi
