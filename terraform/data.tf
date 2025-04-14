data "aws_ami" "aws_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_rds_engine_version" "sql_2022" {
  engine                 = "sqlserver-ex"
  parameter_group_family = "sqlserver-ex-16.0"
}

data "aws_secretsmanager_secret_version" "sql_server_db_password" {
  secret_id = "rds/sql-db-admin-pass"
}

