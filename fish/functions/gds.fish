function gds -d "git diff viewer"
    git rev-parse --is-inside-work-tree >/dev/null || return 1
    if count $argv >/dev/null
        if git rev-parse "$1" >/dev/null 2>&1
            set commit "$1" && set files "$2"
        else
            set files "$argv"
        end
    end

    set repo (git rev-parse --show-toplevel)
    set cmd "echo {} | sed 's/.*]  //' | xargs -I% git diff --staged $commit -- '$repo/%' | $GIT_PAGER"
    set opts "
        $FORGIT_FZF_DEFAULT_OPTS
        +m -0 --bind=\"enter:execute($cmd |env LESS='-r' less)\"
        $FORGIT_DIFF_FZF_OPTS
    "

    eval "git diff --staged --name-only $commit -- $files* | sed -E 's/^(.)[[:space:]]+(.*)\$/[\1]  \2/'" | env FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd"
end
