#!/bin/bash
container_name=$1

# URL to your Prometheus query endpoint
URL="http://localhost:9090/api/v1/query?query=kepler_container_joules_total\{container_name=\"$container_name\",mode=\"dynamic\"\}"
echo "querying URL: $URL"
echo ""
response=$(curl -s "$URL")
echo "response: $response"
echo ""
joules=$(echo "$response" | jq -r '.data.result[0].value[1]')
echo "Joules: $joules"
echo ""

current_joules=$(redis-cli -h localhost -p 6378 -a UUeBDxH6ea HGET "pod_joules" "fibonacci")

if [[ -z "$current_joules" ]] || (( $(echo "$joules < $current_joules" | bc -l) )); then
    echo "Updating fibonacci value to new joules value $joules (was $current_joules)"
    # Update the Redis database if the new joules value is smaller
    redis-cli -h localhost -p 6378 -a UUeBDxH6ea HSET  "pod_joules" "fibonacci" "$joules"
elif (( $(echo "$joules > $current_joules" | bc -l) )); then
    echo "New joules value $joules is greater than current $current_joules for fibonacci. Reverting the deployment."
    # Additional actions, e.g., undeploy the pod
    kubectl delete -f "$container_name-job.yaml" --namespace=default
fi
