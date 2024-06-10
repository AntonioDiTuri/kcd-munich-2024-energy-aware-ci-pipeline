# kcd-munic-2024


## Cluster 

Install kind following the quick-start instructions: https://kind.sigs.k8s.io/docs/user/quick-start/#installation 

From (Kepler's instructions)[https://sustainable-computing.io/installation/local-cluster/#install-kind] to install Kind cluster: 

```
export CLUSTER_NAME="cluster-demo"
kind create cluster --name=$CLUSTER_NAME --config=./local-cluster-config.yaml
```