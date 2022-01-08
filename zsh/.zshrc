alias bb='brew bundle install --cleanup'
alias gaa='git add -A'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcan!='git commit --amend --no-edit'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git chckout'
alias gcob='git chckout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gfap='git fetch --all --prune'
alias gl='git pull'
alias glg='git log --graph'
alias glo='git log --oneline --decorate'
alias glga='git log --graph --decorate --all'
alias glgoa='git log --graph --oneline --decorate --all'
alias gls='git log --stat --paginate'
alias gp='git push'
alias gp!='git push -f'
alias gpu="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbs='git rebase --skip'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias ll='ls -Aho'
alias tf='terraform'
alias tg='terragrunt'

HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups share_history
setopt pushd_ignore_dups auto_cd auto_pushd

. <(brew shellenv)
. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"

autoload -Uz compinit promptinit
promptinit
compinit -d "${HOME}/.zcompdump"

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

