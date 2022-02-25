variable "cidr_block" {
    default = "172.16.0.0/16"
    type = string
}

variable "vpc_name" {
    default = " "
}

variable "az_count" {
    default = "3"
}

variable "azs" {
    type = list
    default = ["us-west-2a","us-west-2b","us-west-2c"]
}

variable "private-subnets" {
    type = list
    default = ["dev-private-subnet"]
}

variable "public-subnets" {
    type = list
    default = ["dev-public-subnet"]
}

variable "eks_name" {
    default = " "
}