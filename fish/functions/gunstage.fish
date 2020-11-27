function gunstage -d "git reset HEAD (unstage) selector"
    git rev-parse --is-inside-work-tree >/dev/null || return 1
    set cmd "git diff --cached -- {} | $GIT_PAGER"
    set opts "
        $FORGIT_FZF_DEFAULT_OPTS
        -m -0
        $FORGIT_RESET_HEAD_FZF_OPTS
    "
    set files (git diff --cached --name-only --relative | env FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd")
    if test -n "$files"
        for file in $files
            echo $file | tr '\n' '\0' | xargs -I{} -0 git reset -q HEAD {}
        end
        git status --short
        return
    end
    echo 'Nothing to unstage.'
end
