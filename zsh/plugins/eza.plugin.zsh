if (( ! $+commands[eza] )); then
  echo "eza is not installed. Please install it to use this plugin."
  return
fi

alias ls="eza --git --group-directories-first --time-style long-iso"
alias tree="eza -aT"
