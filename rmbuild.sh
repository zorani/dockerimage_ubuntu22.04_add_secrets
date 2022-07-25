#!/usr/bin/env bash

. ./ic.config
. ./bashfunctions.sh

remove_secrets
#add_secrets

docker stop $container_name
docker rm $container_name
docker rmi $image_name
#docker build -t $image_name .
#docker run -dit --name $container_name $image_name

remove_secrets
