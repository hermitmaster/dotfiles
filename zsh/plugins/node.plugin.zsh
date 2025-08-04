if (( ! $+commands[node] )); then
  echo "Node.js is not installed. Please install it to use this plugin."
  return
fi

export NPM_CONFIG_PREFIX="$HOME/.local"
export NPM_CONFIG_PYTHON=""
