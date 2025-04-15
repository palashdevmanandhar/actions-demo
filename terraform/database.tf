# resource "aws_db_instance" "sql_server_engine" {
#   allocated_storage                   = 20
#   auto_minor_version_upgrade          = false
#   availability_zone                   = "us-east-1b"
#   backup_retention_period             = 7
#   backup_target                       = "region"
#   backup_window                       = "05:28-05:58"
#   ca_cert_identifier                  = "rds-ca-rsa2048-g1"
#   character_set_name                  = "SQL_Latin1_General_CP1_CI_AS"
#   copy_tags_to_snapshot               = true
#   custom_iam_instance_profile         = null
#   customer_owned_ip_enabled           = false
#   database_insights_mode              = "standard"
#   db_name                             = null
#   db_subnet_group_name                = "default-vpc-0e6d528a0d36fc1f2"
#   dedicated_log_volume                = false
#   delete_automated_backups            = true
#   deletion_protection                 = true
#   domain                              = null
#   domain_auth_secret_arn              = null
#   domain_fqdn                         = null
#   domain_iam_role_name                = null
#   domain_ou                           = null
#   enabled_cloudwatch_logs_exports     = []
#   engine                              = "sqlserver-ex"
#   engine_lifecycle_support            = null
#   engine_version                      = "16.00.4185.3.v1"
#   iam_database_authentication_enabled = false
#   identifier                          = "rds-sql-server-database-1"
#   identifier_prefix                   = null
#   instance_class                      = "db.t3.medium"
#   iops                                = 3000
#   kms_key_id                          = "arn:aws:kms:us-east-1:992382555771:key/6fd1af1d-5d9b-4e48-87a0-d1b4c2714dd9"

#   license_model                         = "license-included"
#   maintenance_window                    = "tue:04:12-tue:04:42"
#   max_allocated_storage                 = 0
#   monitoring_interval                   = 0
#   monitoring_role_arn                   = null
#   multi_az                              = false
#   nchar_character_set_name              = null
#   network_type                          = "IPV4"
#   option_group_name                     = "default:sqlserver-ex-16-00"
#   parameter_group_name                  = "default.sqlserver-ex-16.0"
#   performance_insights_enabled          = true
#   performance_insights_kms_key_id       = "arn:aws:kms:us-east-1:992382555771:key/6fd1af1d-5d9b-4e48-87a0-d1b4c2714dd9"
#   performance_insights_retention_period = 7
#   port                                  = 1433
#   publicly_accessible                   = true
#   replica_mode                          = null
#   replicate_source_db                   = null
#   skip_final_snapshot                   = true
#   storage_encrypted                     = true
#   storage_throughput                    = 125
#   storage_type                          = "gp3"
#   tags                                  = {}
#   tags_all                              = {}
#   timezone                              = null
#   username                              = "admin"
#   vpc_security_group_ids = [
#     "sg-0070ff845178cc528",
#   ]
# }



resource "aws_db_instance" "rds_sql_server" {
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  backup_target              = "region"
  copy_tags_to_snapshot     = true
  db_name                    = null
  db_subnet_group_name       = aws_db_subnet_group.default.name
  delete_automated_backups   = true
  deletion_protection        = true
  engine                     = "sqlserver-ex"
  engine_lifecycle_support   = null
  engine_version             = data.aws_rds_engine_version.sql_2022.version
  identifier                 = "rds-sql-erver"
  instance_class             = "db.t3.medium"
  iops                       = 3000
  network_type               = "IPV4"
  port                       = 1433
  publicly_accessible        = true
  storage_throughput         = 125
  storage_type               = "gp3"
  username                   = "admin" # Replace with your username
  password                   = data.aws_secretsmanager_secret_version.sql_server_db_password.secret_string
  tags = {
    Name = "RDS-SQL-Server-VPC"
  }
  vpc_security_group_ids = [
    aws_security_group.rds_sg.id, # Use the security group you defined
  ]
}



