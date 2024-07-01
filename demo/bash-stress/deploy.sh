#!/bin/sh

# export IMAGE_NAME=stress-loop:latest
# docker build . -t $IMAGE_NAME
# kind load docker-image $IMAGE_NAME
kubectl delete -f Deployment.yaml --force
kubectl apply -f Deployment.yaml