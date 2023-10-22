resource "aws_iam_role" "tech-challenge-cluster" {
  name = "terraform-eks-tech-challenge-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tech-challenge-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.tech-challenge-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "tech-challenge-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.tech-challenge-cluster.name}"
}

resource "aws_security_group" "tech-challenge-cluster" {
  name        = "terraform-eks-tech-challenge-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.tech-challenge.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-tech-challenge"
  }
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "tech-challenge-cluster-ingress-workstation-https" {
  cidr_blocks       = ["191.162.56.21/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.tech-challenge-cluster.id}"
  to_port           = 443
  type              = "ingress"
}