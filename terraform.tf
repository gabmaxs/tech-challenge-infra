terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
  }

  required_version = "~> 1.3"

}
