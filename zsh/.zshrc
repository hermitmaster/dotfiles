if (( ! $+commands[brew] )); then
  echo "Homebrew not found. Run 'make bootstrap' from ~/.config to set up your dotfiles."
fi

# Load functions and completion (with caching)
autoload -Uz $XDG_CONFIG_HOME/zsh/functions/*(:t) compinit

# Completions Homebrew does not ship as _<tool> files. Generated into the cache
# dir and refreshed only when the tool's binary is newer than the cached file,
# so the subprocess cost is paid on upgrade rather than on every shell. This
# must run before compinit. fpath is typeset -U (.zprofile), so the prepend is
# idempotent even though .zprofile already lists the directory.
zcompgen="$XDG_CACHE_HOME/zsh/completions"
[[ -d "$zcompgen" ]] || mkdir -p "$zcompgen"
fpath=("$zcompgen" $fpath)
zcompgen_added=0
for _tool in kubectl helm docker kubebuilder k3d skaffold conftest \
             cmctl golangci-lint infracost; do
  (( $+commands[$_tool] )) || continue
  if [[ ! -s "$zcompgen/_$_tool" || $commands[$_tool] -nt "$zcompgen/_$_tool" ]]; then
    if $_tool completion zsh >| "$zcompgen/_$_tool" 2>/dev/null; then
      zcompgen_added=1
    else
      rm -f "$zcompgen/_$_tool"
    fi
  fi
done
unset _tool zcompgen

# Rebuild the dump at most once a day; -C then skips the (slow) security scan.
# The freshness test MUST be an array glob: zsh does not perform filename
# generation on [[ ]] operands, so the previous `[[ -n ...(#qN.mh+24) ]]` was
# always true and -C never ran. A bare (N...) qualifier also avoids needing
# EXTENDED_GLOB, which this file does not set.
zcompdump="$XDG_CACHE_HOME/zsh/zcompdump"
[[ -d "${zcompdump:h}" ]] || mkdir -p "${zcompdump:h}"
zcompdump_fresh=( ${zcompdump}(N.mh-24) )
if (( $#zcompdump_fresh && ! zcompgen_added )); then
  compinit -C -d "$zcompdump"
else
  compinit -d "$zcompdump"
  # compinit only rewrites the dump when the completion functions actually
  # changed, so its mtime can stay stale and defeat the check above forever.
  # Stamp it explicitly to restart the 24h clock.
  touch "$zcompdump"
fi
unset zcompdump zcompdump_fresh zcompgen_added

# terraform and terragrunt expose a bash-style completion handler over the
# COMP_LINE protocol rather than a zsh function, so they need bashcompinit --
# which must be loaded after compinit.
if (( $+commands[terraform] || $+commands[terragrunt] )); then
  autoload -Uz bashcompinit && bashcompinit
  (( $+commands[terraform] ))  && complete -o nospace -C "$commands[terraform]" terraform
  (( $+commands[terragrunt] )) && complete -o nospace -C "$commands[terragrunt]" terragrunt
fi

# Completion behaviour
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
# Progressive relaxation: exact, then case-insensitive, then substring -- which
# is what makes long prefixed names (AWS SSO profiles, k8s resources) usable.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:warnings'     format '%F{red}-- no matches --%f'
# Scoped to the completion menu so it does not affect eza, which reads LS_COLORS.
zstyle ':completion:*' list-colors 'di=1;34' 'ln=1;36' 'ex=1;32' ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
# Cache the expensive completers (aws, kubectl resource lookups, ...)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,%cpu,comm -w'
zstyle ':completion:*:*:*:*:processes' menu yes select

# Keymap must be explicit. zsh picks viins automatically when $EDITOR/$VISUAL
# matches *vi* -- and "nvim" matches -- so this shell was silently in vi mode
# as a side effect of the editor aliases below. Pin it. Use `bindkey -e` for
# emacs keybindings instead.
bindkey -v

# Tool configurations and aliases
## bat - better cat
if (( $+commands[bat] )); then
  # bat implements most of cat(1)'s flags (-A -n -s -u) but rejects
  # -b -e -t -v -E -T outright, so a blanket `alias cat=bat` breaks them.
  # Route only those through the real cat and use bat for everything else.
  cat() {
    local arg
    for arg in "$@"; do
      [[ $arg == -- ]] && break
      [[ $arg == -[A-Za-z]* && $arg == *[betvET]* ]] && { command cat "$@"; return }
    done
    command bat "$@"
  }

  export BAT_THEME="ansi"
fi

## eza - better ls (replaces conflicting aliases)
if (( $+commands[eza] )); then
  typeset -ga eza_params=('--git' '--icons' '--group-directories-first' '--time-style=long-iso' '--group')
  alias ls='eza ${eza_params}'
  alias l='eza --git-ignore ${eza_params}'
  alias ll='eza --all --header --long ${eza_params}'
  alias llm='eza --all --header --long --sort=modified ${eza_params}'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree'
  alias tree='eza --tree'
fi

## nvim
if (( $+commands[nvim] )); then
  alias v="nvim"
  alias vi="nvim"
  alias vim="nvim"

  export EDITOR="nvim"
  export MANPAGER="nvim +Man! +'set ch=0'"
  export VISUAL="nvim"
fi

## python
alias pip="pip3"
alias python="python3"

## fzf - fuzzy finder
if (( $+commands[fzf] )); then
  # Supported integration as of fzf 0.48; also enables **<TAB> completion.
  eval "$(fzf --zsh)"

  export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --info=inline"

  # fd respects .gitignore and reaches hidden files; without it fzf falls back
  # to its own walker.
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --type=f --hidden --follow --exclude=.git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --follow --exclude=.git"
  fi

  (( $+commands[bat] )) && \
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
  (( $+commands[eza] )) && \
    export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"
fi

## zsh-autosuggestions
if [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

## starship prompt
# Replaces Pure. starship/starship.toml replicates the zstyle colors and the
# single-line layout that used to live here; it is only found there because
# .zshenv points $STARSHIP_CONFIG at it -- starship's own default is
# $XDG_CONFIG_HOME/starship.toml, i.e. the repo root.
#
# Unlike Pure, starship renders synchronously and never fetches, so the git
# segment can lag on a huge repo and the up/down arrows only move after you
# fetch yourself.
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# History
# These MUST be set here, not in .zshenv: macOS /etc/zshrc runs in between and
# hardcodes HISTFILE/HISTSIZE/SAVEHIST, silently overriding anything earlier.
HISTFILE="$XDG_STATE_HOME/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=200000
SAVEHIST=100000

# Shell options
## History
# append_history is on by default, and the manual says inc_append_history
# should be OFF when share_history is set -- share_history already appends
# incrementally as well as importing. Neither is listed here for that reason.
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
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

## direnv - per-directory environments
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

## zoxide - smarter cd
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

## zsh-syntax-highlighting (must be loaded last)
if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Registered by filtering-then-appending rather than a bare += so that
# re-sourcing .zshrc does not run the hook twice per prompt.
precmd_functions=(${precmd_functions:#set_window_title} set_window_title)
preexec_functions=(${preexec_functions:#set_window_title} set_window_title)

