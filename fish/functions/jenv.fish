function jenv -w "jenv" --description "Make jenv play nicely with fish shell"
    set cmd $argv[1]
    set arg ""
    if test (count $argv) -gt 1
        set arg $argv[2..-1]
    end

    switch "$cmd"
        case enable-plugin rehash shell shell-options
            set script (jenv "sh-$cmd" "$arg")
            eval $script
        case '*'
            command jenv $cmd $arg
    end
end
