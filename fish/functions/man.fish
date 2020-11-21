function man -w man -d "man, colorized"
    set -x GROFF_NO_SGR 1
    set -x LESS_TERMCAP_md (tput bold; tput setaf 6)
    set -x LESS_TERMCAP_me (tput sgr0)
    set -x LESS_TERMCAP_ue (tput rmul; tput sgr0)
    set -x LESS_TERMCAP_us (tput smul; tput bold; tput setaf 2)
    set -x LESS_TERMCAP_se (tput rmso; tput sgr0)
    set -x LESS_TERMCAP_so (tput bold; tput setaf 4)
    set -x LESS_TERMCAP_mr (tput rev)
    set -x LESS_TERMCAP_mh (tput dim)

    command man $argv
end
