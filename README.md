# kcd-munich-2024

## Prerequisites:

Kind cluster and Kepler are installed using make files in the Kepler repo.
The make file works if the following are installed:

- Golang
- Docker
- Kubectl

## Overview:

This is a demo about a possible demonstration of Kepler in the realm of CI/CD pipelines on a local setup.

What we will do together: 

1. Set up a local cluster & install Prometheus Grafana
2. Install Kepler
3. Install Redis
4. Install act
5. Run the pipeline (to simulate a Github action locally)

Moreover in the demo repo there are a few use cases that can be tested once kepler is setup:
- ollama: with the objective of running a local llm and observe the energy consumption
- k8sgpt: to compare a local model running with an ai-powered deployment that doesn't host the llm model locally
- bash-stress: with this deployment you can stress different hardware components and check how the energy consumption is changing upon that

## Cluster 

Install kind following the quick-start instructions: https://kind.sigs.k8s.io/docs/user/quick-start/#installation 

Clone kepler repo:
```
git clone https://github.com/sustainable-computing-io/kepler.git
```

Install cluster with Prometheus & Grafana:
```
cd kepler && make cluster-up
```


Install metrics server: 
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch -n kube-system deployment metrics-server --type=json \
  -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
```

Install Kepler:
```
make build-manifest OPTS="PROMETHEUS_DEPLOY"
kubectl apply -f _output/generated-manifest/deployment.yaml
```

Install Redis:
```
helm install my-redis bitnami/redis
```

Port forward to Promethus, Grafana and Kepler:
```
kubectl port-forward --address localhost -n kepler service/kepler-exporter 9102:9102 &
kubectl port-forward --address localhost -n monitoring service/prometheus-k8s 9090:9090 &
kubectl port-forward --address localhost -n monitoring service/grafana 3000:3000 &
```

Install Act
```
brew install act
```

Run pipeline
```
act -P ubuntu-latest=-self-hosted 
```

## Possible extensions

While doing the demo I was suggested to offer a virtual environment setup to avoid the installation of too many binaries.
Feel free to reach out if you would like to contribute on it.

Investigate how the energy consumption changes if you change on programming language for the fibonacci pod or docker base image. 
