set -gx TERMINFO /usr/local/opt/ncurses/share/terminfo/

if status --is-interactive
    if set -q $TMUX && set -q $VIM
        tmux attach || exec tmux
    end
end
