#!/bin/bash
set -e

COMPONENT=$1
TAG=$2

echo "🚀 Deploying ${COMPONENT} to EKS..."

aws eks update-kubeconfig --name ${PROJECT_NAME}-eks --region ${AWS_REGION}

cd k8s/charts/${COMPONENT}
helm upgrade --install ${COMPONENT} . \
  -n ${K8S_NAMESPACE} \
  --set image.repository=${ECR_REPO} \
  --set image.tag=${COMPONENT}-${TAG}

echo "✅ ${COMPONENT} deployed successfully!"
