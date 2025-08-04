if (( ! $+commands[btm] )); then
  echo "btm is not installed. Please install it to use this plugin."
  return
fi

alias btm="btm --basic"
