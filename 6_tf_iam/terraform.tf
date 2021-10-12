terraform {
  backend "s3" {
    bucket = "devops-exercise-tfstate"
    key    = "demo/terraform.tfstate"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
