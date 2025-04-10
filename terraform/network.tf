# module "demo_vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = var.project_name
#   cidr = var.vpc_cidr_block

#   azs            = slice(data.aws_availability_zones.available.names, 0, 2)
#   public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

#   manage_default_security_group = false

# }