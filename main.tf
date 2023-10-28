terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }

  cloud {
    organization = "gabmaxs"

    workspaces {
      name = "tech-challenge"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
