#!/usr/bin/env bash

set -euo pipefail

function cleanup {
  echo "Tearing down docker-compose environment"
  docker-compose down -v
}

trap cleanup EXIT

echo "Building images"
docker-compose build

echo "Bringing up test environment"
docker-compose up -d

# Wait to ensure everything is alive
echo "Waiting a few seconds to make sure everything is alive"
sleep 5

echo "Getting /foo a few times to ensure some metrics exist"
for REQUEST in $(seq 1 3); do
  echo "Request $REQUEST"
  curl --no-progress-meter --fail -X GET "http://127.0.0.1:3000/foo" >>/dev/null
done

echo "Sleeping a few seconds to allow metrics to be scraped and pushed"
for SECONDS in $(seq 15 -1 1); do
  echo "$SECONDS "
  sleep 1
done

echo "Checking labels are being sent"
LABEL_RESPONSE=$(curl --no-progress-meter -X GET http://127.0.0.1:9090/api/v1/label/ecsClusterName/values)
LABEL=$(jq -r '.data[0]' <<< "$LABEL_RESPONSE")

if [ "$LABEL" != "local-test" ]; then
  echo "ERROR: Labels were not set correctly."
  echo "Received the following reply when querying for labels:"
  jq <<< "$LABEL_RESPONSE"
  exit 1
fi

echo "Checking values are being sent"
QUERY_RESPONSE=$(curl --no-progress-meter -X GET http://127.0.0.1:9090/api/v1/query?query=page_count_foo)
METRIC_VALUE=$(jq -r '.data.result[0].value[1]' <<< "$QUERY_RESPONSE")

if [ "$METRIC_VALUE" != "3" ]; then
  echo "ERROR: The metric value was not set correctly."
  echo "Received the following reply when querying for metric data:"
  jq <<< "$QUERY_RESPONSE"
  exit 1
fi

echo "Success! Built ADOT sidecar seems good!"
