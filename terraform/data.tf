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
  engine = "sqlserver-web"

  engine_version      = "16"
  parameter_group_family = "sqlserver-se-16.0"
}