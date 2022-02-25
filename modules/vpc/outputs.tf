output "vpc_id" {
    value = aws_vpc.main.id
    description = "The main VPC ID"
}

output "dev_public_subnets" {
    value = aws_subnet.dev-public-subnet[*].id
    description = "dev public subnets to launch vpc"
}

output "dev_private_subnets" {
    value = aws_subnet.dev-private-subnet[*].id
    description = "dev private subnets to launch vpc"
}