terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.main_region
  default_tags {
    tags = {
      Environment = "dev"
      Project     = var.project_name
    }
  }
}


terraform {
  backend "s3" {
    bucket         = "tf-state-react-jenkin-12312"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
