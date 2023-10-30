provider "kubernetes" {
  host = module.eks.cluster_endpoint
  token = module.eks.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = local.region
}

locals {
  name   = var.cluster-name
  region = var.region

  vpc_cidr = "10.123.0.0/16"
  azs      = ["ap-east-1a", "ap-east-1b"]

  public_subnets  = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnets = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnets   = ["10.123.5.0/24", "10.123.6.0/24"]

  tags = {
    Example = local.name
  }
}
