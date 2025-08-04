if (( !$+commands[pip3] )); then
  echo "pip3 is not installed. Please install it to use this plugin."
  return
fi

alias pip="pip3"
alias python="python3"
