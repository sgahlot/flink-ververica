#!/bin/sh

source .env
rhoas status
rhoas kafka describe --name ${INSTANCE_NAME}
