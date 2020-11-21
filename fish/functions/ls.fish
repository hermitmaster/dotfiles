function ls -w exa --description 'Always colorize ls output'
    exa --git --group-directories-first --time-style=long-iso $argv
end
