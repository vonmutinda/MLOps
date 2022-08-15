#!/usr/bin/env bash

# NB: set dockerpath and version in the Makefile
version=v1.0.0

make build

if [ "$(docker ps -aqf "name=mlops-$version")" ]
then
    # stop and rm running version
    docker stop mlops-$version
    docker rm mlops-$version
else
    # tag image 
    docker tag mlops vonmutinda/mlops:$version
fi

make server

docker ps | grep 'mlops'
