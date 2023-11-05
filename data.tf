data "aws_eks_cluster_auth" "tech-challenge" {
  name = module.eks.cluster_name
}