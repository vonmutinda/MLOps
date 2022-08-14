#!/usr/bin/env bash

# global vars
dockerpath=vonmutinda/mlops
environment=development
port=5050
version=v1.0.1

# build image 
docker build -t mlops .

# tag image
docker tag mlops $dockerpath:$version

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

# port forward - NB: might fail if the pod is not ready
kubectl port-forward deployment.apps/mlops $port:80
