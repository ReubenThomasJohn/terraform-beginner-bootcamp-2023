terraform {
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "terraform-beginners-bootcamp"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  # cloud {
  #   organization = "terraform-beginners-bootcamp"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}


