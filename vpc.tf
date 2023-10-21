data "aws_availability_zones" "available" {}

resource "aws_vpc" "tech-challenge" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "Name", "eks-tech-challenge-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "tech-challenge" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.tech-challenge.id}"

  tags = "${
    map(
     "Name", "eks-tech-challenge-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "tech-challenge" {
  vpc_id = "${aws_vpc.tech-challenge.id}"

  tags = {
    Name = "eks-tech-challenge"
  }
}

resource "aws_route_table" "tech-challenge" {
  vpc_id = "${aws_vpc.tech-challenge.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tech-challenge.id}"
  }
}

resource "aws_route_table_association" "tech-challenge" {
  count = 2

  subnet_id      = "${aws_subnet.tech-challenge.*.id[count.index]}"
  route_table_id = "${aws_route_table.tech-challenge.id}"
}