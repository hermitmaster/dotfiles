if (($+commands[eza])); then
    alias ls="eza --git --group-directories-first --time-style long-iso"
    alias tree="eza -aT"
fi
