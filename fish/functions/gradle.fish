function gradle -w gradle --description 'Use gradle wrapper if present'
    if [ -x ./gradlew ]
        ./gradlew $argv
    else
        command gradle $argv
    end
end
