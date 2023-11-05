module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.2"

  cluster_name                   = local.name
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.small"]

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    tech-challenge-wg = {

      min_size     = 1
      max_size     = 5
      desired_size = 2

      instance_types = ["t3.small"]

      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      tags = {
        ExtraTag = "tech-challenge"
      }
    }
  }

  tags = local.tags
}

resource "kubernetes_namespace" "tech_challenge" {
  metadata {
    name = "tech-challenge"
  }
}