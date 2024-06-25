# kcd-munic-2024

This is a demo about a possible demonstration of Kepler in the realm of CI/CD pipelines.
What we will do together: 

1. Set up a local cluster & install Prometheus Grafana
2. Install Kepler
3. Deploy a custom application

## Cluster 

Install kind following the quick-start instructions: https://kind.sigs.k8s.io/docs/user/quick-start/#installation 

From [Kepler's instructions](https://sustainable-computing.io/installation/local-cluster/#install-kind) to install Kind cluster: 

```
export CLUSTER_NAME="cluster-demo"
kind create cluster --name=$CLUSTER_NAME --config=./local-cluster-config.yaml
```

Install metrics server: 
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Install Prometheus and Kepler

Install helm: Please refer to [Helm's documentation](https://helm.sh/docs/intro/install/) to get started.

Install Kepler & Kube Prometheus Stack: [Kepler's installation with Helm](https://sustainable-computing.io/installation/kepler-helm/). 

Install Kube Prometheus Stack
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack \
    --namespace monitoring \
    --create-namespace \
    --wait
```

Install Kepler
```
helm repo add kepler https://sustainable-computing-io.github.io/kepler-helm-chart
helm repo update

helm install kepler kepler/kepler \
    --namespace kepler \
    --create-namespace \
    --set serviceMonitor.enabled=true \
    --set serviceMonitor.labels.release=prometheus \
```