if (( ! $+commands[bat] )); then

  echo "bat is not installed. Please install it to use this plugin."
  return
fi

export BAT_THEME="ansi"
alias cat="bat"
