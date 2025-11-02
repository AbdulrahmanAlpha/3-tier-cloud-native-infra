output "db_endpoint" {
  value = aws_db_instance.appdb.address
}

output "db_password" {
  value     = random_password.db_pass.result
  sensitive = true
}
