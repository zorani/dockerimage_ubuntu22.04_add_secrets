#!/usr/bin/env bash

#Source image and container names.
. ./ic.config
#Import helper bash functions.
. ./bashfunctions.sh

#A new temporary docker file is created with user secret envs by copying the origional Dockerfile and appending the secret envs to the end.
#Choose and set the name of your temporary dockerfile here.
dockerfile_tmp="ENVDockerfile"

#Append user secret envs to the end of the temporary docker file.
add_envs_to_dockerfile_tmp $dockerfile_tmp

#Manage secret files to be copied to your docker image.
#First remove any existing secret files from the docker context.
remove_secrets
#Now add user secret files to the context.
add_secrets

#Start the rebuild process.
docker stop $container_name 
docker rm $container_name 
docker rmi $image_name 
docker build -q -t $image_name -f $dockerfile_tmp .
docker run -dit --name $container_name $image_name 

#Remove all secrets, secret files and also files containing secret envs.
remove_secrets
rm $dockerfile_tmp
