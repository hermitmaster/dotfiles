if [[ ! -d $HOME/.rd/bin/ ]]; then
  echo "Rancher Desktop is not installed. Please install it to use this plugin."
  return
fi

path=(
  $HOME/.rd/bin(N)
  $path
)
