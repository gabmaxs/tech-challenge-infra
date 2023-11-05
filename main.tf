provider "kubernetes" {
  host = module.eks.cluster_endpoint
  token = data.aws_eks_cluster_auth.tech-challenge.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = local.region
}

locals {
  name   = var.cluster-name
  region = var.region

  vpc_cidr = "10.123.0.0/16"
  azs      = ["${var.region}a", "${var.region}b"]

  public_subnets  = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnets = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnets   = ["10.123.5.0/24", "10.123.6.0/24"]

  tags = {
    ClusterName = local.name
  }
}
