. <(brew shellenv)

export XDG_CONFIG_HOME="${HOME}/.config"
export BAT_THEME="Monokai Extended"
export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/.Brewfile"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"
export TIME_STYLE="long-iso"

alias bb='brew bundle install --cleanup'
alias ls='exa --git --group-directories-first'
alias l='ls -blF'
alias ll='ls -al'
alias llm='ll --sort=modified'
alias la='ls -abghilmu'
alias lx='ls -abghilmuHSU@'
alias tf='terraform'
alias tg='terragrunt'
alias tree='exa --tree'

setopt hist_ignore_all_dups share_history

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install

autoload -Uz compinit && compinit

. <(starship init zsh)
. <(zoxide init zsh --cmd cd)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -z $TMUX && -z $VIM ]]; then
  tmux attach 2>/dev/null || exec tmux
fi

function man {
  env \
    LESS_TERMCAP_md=$(tput bold; tput setaf 1) \
    LESS_TERMCAP_so=$(tput rev; tput setaf 4) \
    LESS_TERMCAP_us=$(tput smul; tput setaf 5) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_ue=$(tput sgr0) \
    LESS_TERMCAP_se=$(tput sgr0) \
    PAGER="less -s -MR +Gg" \
    command man "${@}"
}

