#!/bin/bash

SECRET_IDENTIFIER=$SECRET_IDENTIFIER

AWS_SECRETS_LIST=$(aws secretsmanager list-secrets --query "SecretList[?Name.contains(@, '$SECRET_IDENTIFIER')] [].[Name]" --output text)

for secret in $AWS_SECRETS_LIST
do
    SHORT_AWS_SECRET_NAME=$(echo $secret | sed 's/'-$SECRET_IDENTIFIER'//g' | tr '[:lower:]' '[:upper:]')
    SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id $secret --query SecretString --output text --version-stage AWSCURRENT)
    echo "::add-mask::$SECRET_VALUE"
    echo "$SHORT_AWS_SECRET_NAME=$SECRET_VALUE" >> $GITHUB_ENV
done
