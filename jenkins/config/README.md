# Jenkins Configuration

## Required Credentials
| ID | Type | Description |
|----|------|--------------|
| `aws-cred` | AWS Credentials | IAM user with ECR, EKS, S3 access |
| `dockerhub-cred` | Username/Password | For pulling base images |
| `k8s-cluster` | Text | Optional EKS kubeconfig context |

## Plugins to Install
- AWS Credentials
- Docker Pipeline
- Kubernetes CLI Plugin
- Trivy Security Scanner
- Pipeline Utility Steps
