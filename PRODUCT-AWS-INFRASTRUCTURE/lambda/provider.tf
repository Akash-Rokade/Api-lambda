provider "aws" {
    region = "us-east-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key

    default_tags {
        tags = {
            Name = "terraform-aws-lambda"
        }
    }
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "example-org-49d094"
    workspaces {
      prefix = "terraform-"
    }
  }
  required_version = "~> 1.5.6"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "archive" {
    version = "~> 2.0"
}