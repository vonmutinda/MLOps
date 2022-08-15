#!/usr/bin/env bash

# global vars
dockerpath=vonmutinda/mlops
environment=development
port=5050
version=v1.0.0

# build image 
make build

if [ "$(docker ps -aqf "name=mlops-$version")" ]
then
    # stop and remove idle & running version
    docker stop mlops-$version
    docker rm mlops-$version
else
    # tag image 
    docker tag mlops $dockerpath:$version
fi

# push image to a docker repository
echo "ENVIRONMENT: $environment"

if [ "$environment" = "production" ] 
then
    docker login
    docker push $dockerpath:$version
else
    # clean up old deployment pod 
    kubectl delete deployment.apps/mlops
fi

# deploy to k8s cluster
kubectl create deploy mlops --image=$dockerpath:$version

# describe deployments
make cluster-status

# wait for pods to be ready
sleep 10

# port forward - 
# NB: might fail if the pod is not ready - run manually
# make port-forward
kubectl port-forward deployment.apps/mlops $port:80
