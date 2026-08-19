#!/bin/bash

set -e

IMAGE="207844652594.dkr.ecr.eu-west-2.amazonaws.com/lw-devops-pipeline"
CONTAINER_NAME="lw-devops-pipeline"

CURRENT=$(cat /opt/current_version)
PREVIOUS=$(cat /opt/previous_version)

echo "Current version: $CURRENT"
echo "Rolling back to: $PREVIOUS"

docker pull "$IMAGE:$PREVIOUS"

docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true

docker run -d \
  --name "$CONTAINER_NAME" \
  -p 8000:8000 \
  "$IMAGE:$PREVIOUS"

echo "$PREVIOUS" | sudo tee /opt/current_version
echo "$CURRENT" | sudo tee /opt/previous_version

echo "Rollback completed succesfully."