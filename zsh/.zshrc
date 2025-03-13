#!/usr/bin/env zsh

# Shell options
setopt hist_ignore_all_dups inc_append_history share_history
setopt auto_pushd cd_silent pushd_ignore_dups pushd_silent
HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=100000

export CXXFLAGS="-stdlib=libc++"
export EDITOR="nvim"
export MANPAGER="nvim +Man! +'set ch=0'"
export VISUAL="code"

if (( ! $+commands[brew] )); then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
. "${ZDOTDIR}/.p10k.zsh"

. <(zoxide init zsh --cmd cd)
. <(direnv hook zsh)

autoload -Uz compinit && compinit -d "$ZSH_STATE_DIR/zcompdump"

precmd_functions+=set_window_title
preexec_functions+=set_window_title
