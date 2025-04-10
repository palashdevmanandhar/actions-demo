variable "project_name" {
  description = "The name of the project"
  default     = "testing-tf"
  type        = string
}

variable "main_region" {
  description = "my deafult region"
  default     = "us-east-1"
  type        = string
}

variable "instance_type" {
  description = "The EC2 Instance type"
  default     = "t2.micro"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The main CIDR for the VPC"
  default     = "10.0.0.0/16"
  type        = string
}


variable "repo_name" {
  description = "ECR Repo name"
  default     = "my-node-image-holder"
  type        = string
}