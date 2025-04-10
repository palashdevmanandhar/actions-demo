resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2SecurityGroup"
  }
}



# main.tf
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "my-ec2-instance"
  ami           = data.aws_ami.aws_linux.id # Replace with your desired AMI ID
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "MyEC2Instance"
  }
}




# module "ec2" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 5.0"

#   name = "my-ec2"

#   ami           = data.aws_ami.aws_linux.id # Replace with your region-specific AMI
#   instance_type = var.instance_type

#   subnet_id                   = module.demo_vpc.public_subnets[0]
#   vpc_security_group_ids      = [module.web_sg.security_group_id]
#   associate_public_ip_address = true

#   tags = {
#     Environment = "dev"
#     Project     = "myapp"
#   }
# }