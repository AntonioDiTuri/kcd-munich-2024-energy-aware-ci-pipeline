#!/bin/sh

while true; do
  stress --cpu "$CPU_COUNT" --timeout "$DURATION" --vm "$VM" --io "$IO"
  echo "Sleeping for $SLEEP_INTERVAL..."
  sleep "$SLEEP_INTERVAL"
done
