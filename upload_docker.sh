#!/usr/bin/env bash

# Create dockerpath
dockerpath=vonmutinda/mlops
version=v1.0.0

# build image 
docker build -t mlops .

# tag image
docker tag mlops $dockerpath:$version

# Authenticate 
echo "Docker ID and Image: $dockerpath:$version"

docker login

# push image to a docker repository
docker push $dockerpath:$version
