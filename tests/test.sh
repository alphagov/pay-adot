#!/usr/bin/env bash

set -euo pipefail

function cleanup {
  echo "Tearing down docker-compose environment"
  docker compose down -v
}

trap cleanup EXIT

echo "Building images"
docker compose build

echo "Bringing up test environment"
if ! docker compose up -d --wait; then
  echo "Error starting up test environment."
  echo

  for APP in adot-sidecar test-app prometheus; do
    CONTAINER_STATUS=$(docker compose ps "$APP" --format json | jq -r '.State')
    if [ "${CONTAINER_STATUS}" != "running" ]; then
      echo "$APP did not start up correctly. Logs for the container follow"
      echo "==============================================================================================="
      docker compose logs "$APP" --no-color --no-log-prefix
      echo "==============================================================================================="
    fi
  done
  exit 1
fi

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

echo "Checking label fooLabel from the env is being renamed to barLabel"
LABEL_RESPONSE=$(curl --no-progress-meter -X GET http://127.0.0.1:9090/api/v1/label/barLabel/values)
LABEL=$(jq -r '.data[0]' <<< "$LABEL_RESPONSE")

if [ "$LABEL" != "fooValue" ]; then
  echo "ERROR: Labels were not renamed."
  echo "Received the following reply when querying for fooLabel:"
  jq <<< "$LABEL_RESPONSE"
  exit 1
fi

echo "Checking label fooLabel2 from the env is not being renamed"
LABEL_RESPONSE=$(curl --no-progress-meter -X GET http://127.0.0.1:9090/api/v1/label/fooLabel2/values)
LABEL=$(jq -r '.data[0]' <<< "$LABEL_RESPONSE")

if [ "$LABEL" != "fooValue2" ]; then
  echo "ERROR: fooLabel2 was not added."
  echo "Received the following reply when querying for fooLabel2:"
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
