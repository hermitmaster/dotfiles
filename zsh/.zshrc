alias bb='brew bundle install --cleanup'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fpath+="/opt/homebrew/share/zsh/site-functions"

autoload -Uz compinit promptinit \
  && compinit -d "${HOME}/.zcompdump" \
  && promptinit

zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:git:dirty color 5
zstyle :prompt:pure:prompt:continuation color 8
zstyle :prompt:pure:prompt:success color green

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

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

