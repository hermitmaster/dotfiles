function brewup --description 'Update brew and formulae'
    brew update \
        && brew upgrade \
        && brew cleanup \
        && brew doctor
end
