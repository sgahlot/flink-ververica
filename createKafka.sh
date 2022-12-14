#!/bin/bash

source .env

rhoas kafka create --name ${INSTANCE_NAME} --wait
rhoas context set-kafka --name ${INSTANCE_NAME}
rhoas generate-config --type json --overwrite --output-file ${KAFKA_INSTANCE_CONFIG_JSON}

for topic in items customers orders
do
    rhoas kafka topic create --name $topic
done

rhoas service-account create --output-file=./${SA_CRED_JSON} --file-format json --overwrite --short-description=${SA_NAME}
CLIENT_ID=`cat sa-credentials.json | jq -r .clientID`

for topic in items customers orders
do
    rhoas kafka acl grant-access --consumer --producer \
        --service-account ${CLIENT_ID} --topic-prefix ${topic}  --group "${topic}${KAFKA_CONSUMER_GROUP_SUFFIX}" -y
done
