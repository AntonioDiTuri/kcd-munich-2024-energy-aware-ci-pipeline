# kcd-munich-2024

This is a demo about a possible demonstration of Kepler in the realm of CI/CD pipelines.
What we will do together: 

1. Set up a local cluster & install Prometheus Grafana
2. Install Kepler
3. Install Redis
4. Install act
5. Run the pipeline

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
