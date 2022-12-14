#!/usr/bin/env bash

# Create dockerpath
# dockerpath=vonmutinda/mlops
# version=v1.0.0

# # build image 
# docker build -t mlops .

# # tag image
# docker tag mlops $dockerpath:$version

# # Authenticate 
# echo "Docker ID and Image: $dockerpath:$version"

# docker login

# # push image to a docker repository
# docker push $dockerpath:$version

if [ "$(docker ps -aqf "name=devops-v1.0.2")" ]
then
    echo "Stopping and removing devops-v1.0.2"
else
    echo "Docker image doesn't already exists"
fi

# docker ps -aqf "name=devops-v1.0.2"
