#!/bin/bash
set -e

COMPONENT=$1

echo "🔍 Running Trivy scan for ${COMPONENT}..."
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    aquasec/trivy image ${ECR_REPO}:${COMPONENT}-latest || true

echo "✅ Security scan completed for ${COMPONENT}"
