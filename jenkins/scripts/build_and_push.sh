#!/bin/bash
set -e

COMPONENT=$1
TAG=$2

echo "🚀 Building ${COMPONENT} Docker image..."

cd app/${COMPONENT}
IMAGE="${ECR_REPO}:${COMPONENT}-${TAG}"

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}

docker build -t ${IMAGE} .
docker push ${IMAGE}

echo "✅ ${COMPONENT} image pushed: ${IMAGE}"
