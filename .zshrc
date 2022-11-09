export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/Brewfile.rb"

test $(arch) = "arm64" && DEFAULT_HOMEBREW_PREFIX="/opt/homebrew"
. <("${DEFAULT_HOMEBREW_PREFIX:-"/usr/local"}/bin/brew" shellenv)
test -e "${HOMEBREW_BUNDLE_FILE}.lock.json" || brew bundle install --clean

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export PATH="${HOME}/.local/bin:${HOME}/.rd/bin:${PATH}"

alias bb="brew bundle install --clean"
alias btm='btm --basic'
alias docker="nerdctl"
alias kctx="kubectx"
alias kns="kubens"
alias ls="exa --git --group-directories-first --time-style long-iso"
alias ll="ls -al"
alias la="ls -abghilmu"
alias tf="terraform"
alias tg="terragrunt"
alias tree="exa --tree"

setopt hist_ignore_all_dups inc_append_history share_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

. "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
. "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
. "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"
. "${XDG_CONFIG_HOME}/.p10k.zsh"
. <(direnv hook zsh)

fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"
autoload -Uz compinit bashcompinit
compinit
bashcompinit

function _nvim_packer_sync {
  rm -rf "${XDG_CONFIG_HOME}/nvim/plugin/" &>/dev/null
  nvim --headless +'autocmd User PackerComplete quitall' +'PackerSync'
}

function _bs {
  test -f "${HOME}/.hushlogin" || touch "${HOME}/.hushlogin"
  test -L "${HOME}/.zshrc" || ln -fs "${XDG_CONFIG_HOME}/.zshrc" "${HOME}/.zshrc"

  brew bundle install --clean
  _nvim_packer_sync
}

