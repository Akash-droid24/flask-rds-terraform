output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.myrds.address
  depends_on = [
    aws_db_instance.myrds
  ]
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.myrds.port
  depends_on = [
    aws_db_instance.myrds
  ]
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.myrds.username
  sensitive   = true
  depends_on = [
    aws_db_instance.myrds
  ]
}


output "rds_pass" {
  description = "RDS instance pass"
  value = aws_db_instance.myrds.password
  sensitive = true
  depends_on = [
    aws_db_instance.myrds
  ]
}

output "rds_az" {
  description = "RDS availability zone"
  value = aws_db_instance.myrds.availability_zone
  depends_on = [
    aws_db_instance.myrds
  ]
}

output "rds_sg" {
  description = "Security group of RDS database"
  value       = aws_db_instance.myrds.vpc_security_group_ids
  depends_on = [
    aws_security_group.allow_sql
  ]
}

output "rds_database_engine" {
  description = "Engine of RDS database"
  value = aws_db_instance.myrds.engine
  depends_on = [
    aws_db_instance.myrds
  ]
}
