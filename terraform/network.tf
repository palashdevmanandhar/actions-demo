module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.project_name
  cidr = var.vpc_cidr_block

  azs            = data.aws_availability_zones.available.names
  public_subnets = [for i in range(var.public_subnets_count) : cidrsubnet(var.vpc_cidr_block, 8, i)]

  manage_default_security_group = false
}

resource "aws_db_subnet_group" "default" {
  name       = "custom-db-subnet-group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "My DB subnet group"
  }
}