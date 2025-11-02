output "backup_bucket_name" {
  description = "Name of the backup S3 bucket"
  value       = aws_s3_bucket.backup.bucket
}

output "backup_bucket_arn" {
  description = "ARN of the backup S3 bucket"
  value       = aws_s3_bucket.backup.arn
}
