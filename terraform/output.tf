output "latest_sqlserver_web_engine_version" {
  value = data.aws_rds_engine_version.sql_2022.version
}

output "sql_server_endpoint"{
  value = aws_db_instance.rds_sql_server.endpoint
}