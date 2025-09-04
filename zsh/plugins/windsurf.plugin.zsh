if (( ! $+commands[windsurf] )); then

  echo "windsurf is not installed. Please install it to use this plugin."
  return
fi

path=(
  $HOME/.codeium/windsurf/bin(N)
  $path
)
