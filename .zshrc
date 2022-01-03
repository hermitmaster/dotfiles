export CLICOLOR=1
export EDITOR=nvim
export HOMEBREW_BUNDLE_FILE=${HOME}/.config/.Brewfile
export LG_CONFIG_FILE=${HOME}/.config/lazygit.yml
export NPM_CONFIG_PREFIX=${HOME}/.local
export PATH=${HOME}/.local/bin:/opt/homebrew/bin:${PATH}

alias bb='brew bundle install --cleanup'
alias gs='lazygit'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

test -L "${HOME}/.zshrc" || ln -fs "${HOME}/.config/.zshrc" "${HOME}/.zshrc"
test -f "${HOMEBREW_BUNDLE_FILE}.lock.json" || bb

setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

autoload -Uz compinit promptinit && compinit && promptinit

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

