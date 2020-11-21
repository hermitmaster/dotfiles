function mvn -w mvn --description 'Use mvn wrapper if present'
    if [ -x ./mvnw ]
        ./mvnw $argv
    else
        command mvn $argv
    end
end
