variable "backup_principal_arn" {
  description = "IAM role or user ARN allowed to access this backup bucket (e.g., Jenkins EC2 role or Lambda backup function)"
  type        = string
}

variable "backup_retention_days" {
  description = "Retention period in days before backup objects expire"
  type        = number
  default     = 365
}
variable "project_name" {}
variable "environment" {}
