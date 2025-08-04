if (( $+commands[go] )); then
  export GOPATH="$XDG_DATA_HOME/go"
  path=(
    $GOPATH/bin(N)
    $path
  )
fi

