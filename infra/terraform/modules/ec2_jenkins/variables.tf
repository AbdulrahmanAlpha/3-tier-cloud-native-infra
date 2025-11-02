variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet" {
  description = "Public subnet ID for Jenkins EC2"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for Jenkins EC2"
  type        = string
}
variable "project_name" {}
variable "environment" {}
