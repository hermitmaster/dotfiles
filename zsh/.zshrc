#!/usr/bin/env zsh

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"

export BAT_THEME="ansi"
export CXXFLAGS="-stdlib=libc++"
export EDITOR="nvim"
export GOPATH="$XDG_DATA_HOME/go"
export HOMEBREW_BUNDLE_FILE_GLOBAL="$XDG_CONFIG_HOME/brewfile.rb"
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1
export HOMEBREW_PREFIX="/opt/homebrew"
export KUBECONFIG="$HOME/.kube/config"
export LANG="en_US.UTF-8"
export MANPAGER="nvim +Man! +'set ch=0'"
export NPM_CONFIG_PREFIX="$HOME/.local"
export NPM_CONFIG_PYTHON=""
export VISUAL="code"

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"

typeset -gU fpath path
path=(
  $GOPATH/bin(N)
  $HOME/.local/bin(N)
  $XDG_DATA_HOME/nvim/mason/bin(N)
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/bin(N)
  $HOMEBREW_PREFIX/sbin(N)
  $path
)

fpath=(
  $XDG_CONFIG_HOME/zsh/functions(N)
  $HOMEBREW_PREFIX/share/zsh/site-functions(N)
  $HOMEBREW_PREFIX/share/zsh-completions}(N)
  $fpath
)

if (( ! $+commands[brew] )); then
  autoload -Uz bootstrap && bootstrap
fi

# Aliases
alias bb="brew bundle install --global"
alias bbm="bb && mas upgrade"
alias btm="btm --basic"
alias cat="bat"
alias kctx="kubectx"
alias kns="kubens"
alias ls="eza --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias nps="nvim --headless +'Lazy! sync' +qa"
alias pip="pip3"
alias python="python3"
alias tf="terraform"
alias tg="terragrunt"
alias tree="eza -aT"
alias treed="tree -D"
alias uatt="bb && nps"

. "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
. "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

. <(ssh-agent -s) >/dev/null
. <(zoxide init zsh --cmd cd)
. <(direnv hook zsh)

# Shell options
setopt hist_ignore_all_dups inc_append_history share_history
setopt auto_pushd cd_silent pushd_ignore_dups pushd_silent
HISTSIZE=100000

autoload -Uz $XDG_CONFIG_HOME/zsh/functions/*(:t) compinit promptinit
compinit && promptinit

zstyle :prompt:pure:execution_time color 8
zstyle :prompt:pure:git:action color 1
zstyle :prompt:pure:git:branch color 2
zstyle :prompt:pure:git:dirty color 5
zstyle :prompt:pure:host color 8
zstyle :prompt:pure:prompt:success color 2
zstyle :prompt:pure:prompt:continuation color 8
zstyle :prompt:pure:user color 8
zstyle :prompt:pure:virtualenv color 8

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

