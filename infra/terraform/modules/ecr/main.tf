resource "aws_ecr_repository" "app_repo" {
  name = "${var.project_name}-${var.environment}-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
