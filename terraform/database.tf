resource "aws_db_instance" "sql_server_engine" {
  allocated_storage    = 20
  storage_type         = "gp2"
  max_allocated_storage  = 100
  db_name                = "myfirstdb"
  engine                 = "sqlserver-web"
  engine_version         = data.aws_rds_engine_version.sql_2022.version_actual
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "admin123"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
