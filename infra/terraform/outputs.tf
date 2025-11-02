# -----------------------------------------------------
# Outputs — Useful for CI/CD Integration
# -----------------------------------------------------
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "rds_endpoint" {
  description = "RDS Database Endpoint"
  value       = module.rds.db_endpoint
}

output "jenkins_public_ip" {
  description = "Jenkins EC2 Public IP"
  value       = module.jenkins.jenkins_public_ip
}

output "backup_bucket_name" {
  description = "Backup S3 Bucket Name"
  value       = module.s3_backup.backup_bucket_name
}

output "ecr_repo_url" {
  description = "ECR Repository URL"
  value       = module.ecr.repository_url
}
