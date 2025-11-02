variable "vpc_id" {
  description = "VPC ID for RDS"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
}
variable "project_name" {}
variable "environment" {}
