if (( ! $+commands[go] )); then
  echo "Go is not installed. Please install it to use this plugin."
  return
fi

export GOPATH="$XDG_DATA_HOME/go"
path=(
  $GOPATH/bin(N)
  $path
)

