set -gx EDITOR nvim
set -gx MANPAGER "less -s -MR +Gg"
set -gx NPM_CONFIG_PREFIX $HOME/.local
set -gx PAGER less
set -gx TERMINFO /usr/local/opt/ncurses/share/terminfo/
set -p PATH "$HOME/.local/bin"

# Normalize the PATH
set -gx PATH (echo $PATH | tr [:space:] '\n' | awk '!a[$0]++')

if status --is-interactive
    if set -q $TMUX && set -q $VIM
        tmux attach || exec tmux
    end
end
