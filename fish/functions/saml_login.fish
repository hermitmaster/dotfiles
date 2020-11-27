# saml login to AWS
function saml_login -w saml2aws
    if test -z "$argv[1]"
        echo "usage: saml_login { CLUSTER_NAME } { ENVIRONMENT }"
    else
        set CLUSTER $argv[1]
        set ENV $argv[2]

        set -e AWS_ACCESS_KEY_ID
        set -e AWS_SECRET_ACCESS_KEY
        set -e AWS_SESSION_TOKEN
        set -e AWS_SECURITY_TOKEN
        set -e AWS_CREDENTIAL_EXPIRATION
        set -e SAML2AWS_PROFILE

        set -q AWS_DEFAULT_REGION || set -x AWS_DEFAULT_REGION 'us-east-1'
        set -x KUBECONFIG $HOME/.kube/$CLUSTER-$ENV.config

        saml2aws login -a $CLUSTER-$ENV --skip-prompt
        eval (saml2aws script -a $CLUSTER-$ENV --shell=fish)

        if [ ! -f "$KUBECONFIG" ]
            aws eks \
                --profile=$CLUSTER-$ENV \
                --region $AWS_DEFAULT_REGION \
                update-kubeconfig \
                --name $CLUSTER \
                --kubeconfig=$HOME/.kube/$CLUSTER-$ENV.config
        end
    end
end
