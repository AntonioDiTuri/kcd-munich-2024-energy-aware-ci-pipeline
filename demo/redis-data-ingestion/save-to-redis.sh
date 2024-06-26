#!/bin/bash

# URL to your Prometheus query endpoint
URL='http://localhost:9090/api/v1/query?query=kepler_container_joules_total\{pod_name="fibonacci-inefficient"\}'

response=$(curl -s "$URL")

pod=$(echo "$response" | jq -r '.data.result[0].metric.pod_name')
joules=$(echo "$response" | jq -r '.data.result[0].value[1]')

echo "Pod: $pod"
echo "Joules: $joules"

current_joules=$(redis-cli HGET "pod_joules" "$pod")

if [[ -z "$current_joules" ]] || (( $(echo "$joules < $current_joules" | bc -l) )); then
    echo "Updating $pod to new joules value $joules (was $current_joules)"
    # Update the Redis database if the new joules value is smaller
    redis-cli HSET "pod_joules" "$pod" "$joules"
elif (( $(echo "$joules > $current_joules" | bc -l) )); then
    echo "New joules value $joules is greater than current $current_joules for $pod. Taking action."
    # Additional actions, e.g., undeploy the pod
    kubectl delete pod "$pod" --namespace=default
fi
