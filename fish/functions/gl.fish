function gl -d "git commit viewer"
    git rev-parse --is-inside-work-tree >/dev/null || return 1

    set files (echo $argv | sed -nE 's/.* -- (.*)/\1/p')
    set cmd "echo {} | egrep -o '[a-f0-9]+' | head -1 | xargs -I% git show % -- $files | $GIT_PAGER"

    set opts "
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m --tiebreak=index
        --bind=\"enter:execute($cmd |env LESS='-r' less)\"
        --bind=\"ctrl-y:execute-silent(echo {} | egrep -o '[a-f0-9]+' | head -1 | tr -d '\n' | pbcopy)\"
        $FORGIT_LOG_FZF_OPTS
    "

    eval "git log --graph --all --oneline $argv" | env FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd"
end
