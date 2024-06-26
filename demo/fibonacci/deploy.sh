#!/bin/sh

export IMAGE_NAME=efficient-fibonacci:latest

docker build . -t $IMAGE_NAME
kind load docker-image $IMAGE_NAME
kubectl delete -f pod.yaml --force
kubectl apply -f pod.yaml