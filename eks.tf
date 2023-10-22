resource "aws_eks_cluster" "tech-challenge" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.tech-challenge-cluster.arn}"

  vpc_config {
    security_group_ids = [aws_security_group.tech-challenge-cluster.id]
    subnet_ids         = aws_subnet.tech-challenge[*].id
  }

  depends_on = [
    "aws_iam_role_policy_attachment.tech-challenge-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.tech-challenge-cluster-AmazonEKSServicePolicy",
  ]
}

data "aws_eks_cluster_auth" "tech-challenge" {
  name = var.cluster-name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.tech-challenge.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.tech-challenge.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.tech-challenge.token
}

resource "kubernetes_namespace" "tech_challenge" {
  metadata {
    name = "tech-challenge"
  }
}