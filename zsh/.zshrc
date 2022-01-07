alias bb='brew bundle install --cleanup'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

autoload -Uz compinit promptinit
compinit -d "${HOME}/.zcompdump" 

autoload -Uz promptinit && promptinit

zstyle :prompt:pure:execution_time color 8
zstyle :prompt:pure:git:action color 9
zstyle :prompt:pure:git:branch color 2
zstyle :prompt:pure:git:dirty color 9
zstyle :prompt:pure:host color 8
zstyle :prompt:pure:prompt:continuation color 8
zstyle :prompt:pure:user color 8
zstyle :prompt:pure:virtualenv color 8

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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

