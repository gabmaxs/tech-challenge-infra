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