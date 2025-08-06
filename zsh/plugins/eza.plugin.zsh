if (( ! $+commands[eza] )); then
  echo "eza is not installed. Please install it to use this plugin."
  return
fi

eza_params=('--git' '--icons' '--group-directories-first' '--time-style=long-iso' '--group')

alias ls='eza ${eza_params}'
alias l='eza --git-ignore ${eza_params}'
alias ll='eza --all --header --long ${eza_params}'
alias llm='eza --all --header --long --sort=modified ${eza_params}'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree'
alias tree='eza --tree'
