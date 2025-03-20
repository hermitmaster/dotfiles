if (( ! $+commands[brew] )); then
  autoload -Uz bootstrap && bootstrap
fi

if (( $+commands[bat] )); then
  export BAT_THEME="ansi"
  alias cat="bat"
fi

if (( $+commands[btm] )); then
  alias btm="btm --basic"
fi

if (( $+commands[eza] )); then
  alias ls="eza --git --group-directories-first --time-style long-iso"
  alias tree="eza -aT"
fi

if (( $+commands[go] )); then
  export GOPATH="$XDG_DATA_HOME/go"
  path=(
    $GOPATH/bin(N)
    $path
  )
fi

if (( $+commands[node] )); then
  export NPM_CONFIG_PREFIX="$HOME/.local"
  export NPM_CONFIG_PYTHON=""
fi

if (( $+commands[nvim] )); then
  export EDITOR="nvim"
  export MANPAGER="nvim +Man! +'set ch=0'"
  path=(
    $XDG_DATA_HOME/nvim/mason/bin(N)
    $path
  )
fi

if (( $+commands[pip3] )); then
  alias pip="pip3"
  alias python="python3"
fi

# Aliases
alias ll="ls -al"
alias la="ls -abghilmu"
alias treed="tree -D"

# Load plugins
if [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

if [[ -f "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -f "$XDG_CONFIG_HOME/zsh/.p10k.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/.p10k.zsh"
fi

# Load external tools
eval "$(ssh-agent -s)" >/dev/null
eval "$(zoxide init zsh --cmd cd)"
eval "$(direnv hook zsh)"

# Shell options
## History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
## Completion
setopt always_to_end
setopt correct
setopt complete_in_word
## Other
setopt auto_pushd
setopt cd_silent
setopt pushd_ignore_dups
setopt pushd_silent
setopt auto_list
setopt auto_menu

HISTSIZE=$SAVEHIST

autoload -Uz $XDG_CONFIG_HOME/zsh/functions/*(:t) compinit
compinit

precmd_functions+=set_window_title
preexec_functions+=set_window_title
