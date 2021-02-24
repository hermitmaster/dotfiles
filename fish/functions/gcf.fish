function forgit::checkout_file -d "git checkout-restore selector"
    git rev-parse --is-inside-work-tree >/dev/null || return 1

    set cmd "git diff -- {} | $GIT_PAGER"
    set opts "
        $FORGIT_FZF_DEFAULT_OPTS
        -m -0
        $FORGIT_CHECKOUT_FZF_OPTS
    "
    set git_rev_parse (git rev-parse --show-toplevel)
    set files (git ls-files --modified "$git_rev_parse" | env FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd")
    if test -n "$files"
        for file in $files
            echo $file | tr '\n' '\0' | xargs -I{} -0 git checkout -q {}
        end
        git status --short
        return
    end
    echo 'Nothing to restore.'
end
