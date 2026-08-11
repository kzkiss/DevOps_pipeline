#!/bin/bash

set -e

AWS_REGION="eu-west-2"
ECR_REPOSITORY="lw-devops-pipeline"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

ECR_REGISRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
IMAGE="${ECR_REGISRY}/${ECR_REPOSITORY}:latest"

echo "Logging in to AWS ECR..."

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$ECR_REGISRY"

echo "Pulling latest image..."

docker pull "$IMAGE"

echo "Stopping existing container..."

docker stop lightweight-backend-api || true

echo "Removing existing container..."

docker rm lightweight-backend-api || true

echo "Starting new container..."

docker run -d --name lightweight-backend-api -p 8080:8080 "$IMAGE"

echo "Deployment completed successfully."

docker ps
