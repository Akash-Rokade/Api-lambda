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