output "db_endpoints" {
  value = [
    aws_db_instance.db1.endpoint,
    aws_db_instance.db2.endpoint
  ]
}