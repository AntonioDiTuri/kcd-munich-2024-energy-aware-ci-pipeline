#!/bin/sh

export IMAGE_NAME="$1:latest"
docker build . -t $IMAGE_NAME --build-arg arg=$1
kind load docker-image $IMAGE_NAME
kubectl delete -f "$1-job.yaml" --force
kubectl apply -f "$1-job.yaml"