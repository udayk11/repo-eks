#######  vpc creation #########

resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = map(
      "Name", var.vpc_name,
      "kubernetes.io/cluster/${var.eks_name}", "shared",
    )
}