function grbi -d "git rebase "
    git rev-parse --is-inside-work-tree >/dev/null || return 1

    set cmd "git log --graph --format='%C(auto)%h%d %s %C(black)%C(bold)%cr%Creset' $argv"

    set files (echo $argv | sed -nE 's/.* -- (.*)/\1/p')
    set preview "echo {} | egrep -o '[a-f0-9]+' | head -1 | xargs -I% git show % -- $files | $GIT_PAGER"

    set opts "
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m --tiebreak=index
        --bind=\"ctrl-y:execute-silent(echo {} | egrep -o '[a-f0-9]+' | head -1 | tr -d '\n' | pbcopy)\"
        $FORGIT_REBASE_FZF_OPTS
    "
    eval "$cmd" | FZF_DEFAULT_OPTS="$opts" fzf --preview="$preview" |
    grep -Eo '[a-f0-9]+' | head -1 |
    xargs -I% git rebase -i %
end
