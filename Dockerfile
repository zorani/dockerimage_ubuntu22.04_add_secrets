FROM zokidoki/ubuntu22.04_deadsnakes:1.0

#1] Change the base context you would like to add secrets to.
#2] Change the ic.config file to change your docker names.
#3] Don't push your docker container with secrets to docker hub.


USER root 
SHELL ["/bin/bash","-c"]
#You must update each and every time
RUN apt-get update

#These are the default zokidoki user/group names for the non root user.
#Don't change them in the build file.
ARG username=ubuntu
ARG groupname=dockdev

#Makesure your context contains these files with your creds and details
COPY --chown=${username}:${groupname}  .git-credentials /home/ubuntu/
COPY --chown=${username}:${groupname}  .gitconfig /home/ubuntu/

#Make sure your context contains these directories
ADD  --chown=${username}:${groupname} .ssh /home/ubuntu/.ssh/
RUN /usr/bin/chmod 700 /home/ubuntu/.ssh/
RUN /usr/bin/chmod 600 /home/ubuntu/.ssh/*

USER ubuntu
WORKDIR /home/ubuntu/