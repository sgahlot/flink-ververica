#!/bin/bash
source .env

rhoas kafka delete --name ${INSTANCE_NAME} -y
CLIENT_ID=$(grep clientID ./sa-credentials.json | cut -d ":" -f2 | tr -d '", ')
rhoas service-account delete --id ${CLIENT_ID} -y
