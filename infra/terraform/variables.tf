variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

variable "project_name" {
  description = "The project name (used for tagging)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
}
