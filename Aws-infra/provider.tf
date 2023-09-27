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

provider "archive" {
    version = "~> 2.0"
}