####### Subnets #########

resource "aws_subnet" "dev-private-subnet" {
    count = var.az_count
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 7, count.index)
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id
    #map_public_ip_on_launch = true
    tags = {
        Name = "${var.private-subnets[0]}-${count.index+1}"
    }
}

resource "aws_subnet" "dev-public-subnet" {
    count = var.az_count
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 7, count.index+4)
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id
    map_public_ip_on_launch = true
    tags = map(
        "Name", "${var.public-subnets[0]}-${count.index+1}",
        "kubernetes.io/cluster/${var.eks_name}", "shared",
    ) 
}