resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Opens port for conection to sql server"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All ports opend for outbound traffic"
  }

  tags = {
    Name = "RDS-sg"
  }
}

