############################################
# Root Terraform Main Configuration
# Project: 3-Tier Cloud-Native Application
# Author: Abdulrahman A. Muhamad
############################################

# -----------------------------------------------------
# 🔹 VPC Module — Networking Foundation
# -----------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  # Uses global vars from root variables.tf
  project_name = var.project_name
  environment  = var.environment

  # Local VPC configurations
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
}

# -----------------------------------------------------
# 🔹 ECR Module — Container Registry
# -----------------------------------------------------
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------
# 🔹 EKS Module — Kubernetes Cluster
# -----------------------------------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.0"

  cluster_name    = "${var.project_name}-${var.environment}-eks"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}




# -----------------------------------------------------
# 🔹 Jenkins EC2 Module — CI/CD Server
# -----------------------------------------------------
module "jenkins" {
  source       = "./modules/ec2_jenkins"
  project_name = var.project_name
  environment  = var.environment

  vpc_id        = module.vpc.vpc_id
  public_subnet = module.vpc.public_subnets[0]
  key_name      = "jenkins-key" # update with your keypair name
}

# -----------------------------------------------------
# 🔹 S3 Backup Module — Centralized Backup Storage
# -----------------------------------------------------
module "s3_backup" {
  source               = "./modules/s3_backup"
  project_name         = var.project_name
  environment          = var.environment
  backup_principal_arn = "arn:aws:iam::123456789012:role/jenkins-role" # replace later
}
