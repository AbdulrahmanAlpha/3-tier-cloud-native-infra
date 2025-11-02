# --------------------------------------
# S3 Backup Bucket (Versioned + Encrypted)
# --------------------------------------

resource "aws_s3_bucket" "backup" {
  bucket = "${var.project_name}-${var.environment}-backup"

  # Enable bucket versioning (so deleted or overwritten files can be restored)
  versioning {
    enabled = true
  }

  # Enforce encryption at rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable public access block
  acl                 = "private"
  force_destroy       = false
  object_lock_enabled = true
  object_lock_configuration {
    rule {
      default_retention {
        mode = "GOVERNANCE"
        days = 30
      }
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-backup"
    Project     = var.project_name
    Environment = var.environment
    Purpose     = "BackupStorage"
  }
}

# --------------------------------------
# Block all forms of public access
# --------------------------------------
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.backup.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# --------------------------------------
# Enable lifecycle management
# --------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.backup.id

  rule {
    id     = "ExpireOldBackups"
    status = "Enabled"

    # Transition old backups to cheaper storage
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

# --------------------------------------
# Optional: Bucket policy for Jenkins or Lambda backup access
# --------------------------------------
resource "aws_s3_bucket_policy" "backup_policy" {
  bucket = aws_s3_bucket.backup.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowJenkinsAccess"
        Effect = "Allow"
        Principal = {
          AWS = var.backup_principal_arn
        }
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.backup.arn}",
          "${aws_s3_bucket.backup.arn}/*"
        ]
      }
    ]
  })
}
