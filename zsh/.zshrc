if (( ! $+commands[brew] )); then
  echo "Homebrew not found. Run 'make bootstrap' from ~/.config to set up your dotfiles."
fi

# Load functions and completion
autoload -Uz $XDG_CONFIG_HOME/zsh/functions/*(:t) compinit
compinit

# Tool configurations and aliases
## bat - better cat
if (( $+commands[bat] )); then
  alias cat="bat"
fi

## eza - better ls (replaces conflicting aliases)
if (( $+commands[eza] )); then
  eza_params=('--git' '--icons' '--group-directories-first' '--time-style=long-iso' '--group')
  alias ls='eza ${eza_params}'
  alias l='eza --git-ignore ${eza_params}'
  alias ll='eza --all --header --long ${eza_params}'
  alias llm='eza --all --header --long --sort=modified ${eza_params}'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree'
  alias tree='eza --tree'
fi

## Python aliases
if (( $+commands[pip3] )); then
  alias pip="pip3"
  alias python="python3"
fi

## fzf - fuzzy finder
if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

## Powerlevel10k theme
if [[ -f "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -f "$XDG_CONFIG_HOME/zsh/.p10k.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/.p10k.zsh"
fi

## zsh-autosuggestions
if [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
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

precmd_functions+=set_window_title
preexec_functions+=set_window_title

## zsh-syntax-highlighting (must be loaded last)
if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
