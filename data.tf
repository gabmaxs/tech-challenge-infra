data "aws_eks_cluster_auth" "tech-challenge" {
  name = aws_eks_cluster.tech-challenge.name
}