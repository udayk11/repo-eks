variable "cluster_name" {
    type = string
    default = " "
}

variable "cluster_version" {
    default = " "
}

variable "eks_vpc_id" {
    default = " "
}

variable "eks_subnets" {
    default = " "
}

variable "instance_types" {
    type = list
}

variable "capacity_type" {
    default = " "
}

variable "ec2_ssh_key" {
    default = " "
}