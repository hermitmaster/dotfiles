function fish_prompt --description 'Write out the prompt'
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    set -g __fish_git_prompt_char_cleanstate ""
    set -g __fish_git_prompt_char_dirtystate " !"
    set -g __fish_git_prompt_char_invalidstate " ~"
    set -g __fish_git_prompt_char_stagedstate " +"
    set -g __fish_git_prompt_char_stashstate " *"
    set -g __fish_git_prompt_char_stateseparator ""
    set -g __fish_git_prompt_char_untrackedfiles " ?"
    set -g __fish_git_prompt_color_cleanstate green --bold
    set -g __fish_git_prompt_color_dirtystate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles blue
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_show_untrackedfiles true
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_showupstream informative

    # pwd segment
    set_color blue --bold
    printf '%s ' (prompt_pwd)

    # git segment
    if test (git rev-parse --show-toplevel 2>/dev/null)
        fish_git_prompt '%s '
    end

    # prompt_char segment
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end

    switch $fish_bind_mode
        case default
            printf '❮ '
        case visual
            printf 'V '
        case replace replace_one
            printf '▶ '
        case '*'
            printf '❯ '
    end

    # reset colors
    set_color normal
end
