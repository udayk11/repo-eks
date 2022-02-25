#### IGW creation #####

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-IGW"
    }
}

######### Route creation for public trafic through IGW

resource "aws_route" "Internet_Access" {
    route_table_id = aws_vpc.main.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}


######### Route entry for dev public subnets with igw #####

resource "aws_route_table_association" "dev-public" {
    count = var.az_count
    subnet_id = element(aws_subnet.dev-public-subnet.*.id, count.index)
    route_table_id = aws_vpc.main.main_route_table_id
}


#### EIP creation for NAT ####  
resource "aws_eip" "gwip" {
    count = var.az_count
    vpc = true
    depends_on = [aws_internet_gateway.igw]
}


#### NAT creation ####

resource "aws_nat_gateway" "dev" {
    count = var.az_count
    subnet_id = element(aws_subnet.dev-public-subnet.*.id, count.index)
    allocation_id = element(aws_eip.gwip.*.id, count.index)
    tags = {
        Name = "dev-NAT-${count.index+1}"
    }
}


#### NAT Route Table creation ####

resource "aws_route_table" "devprivate" {
    count = var.az_count
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.dev.*.id, count.index)
    }
    
    tags = {
        Name = "Dev-NAT-${count.index+1}"
    }
}

#### NAT association ####

resource "aws_route_table_association" "dev-private-association" {
    count = var.az_count
    subnet_id = element(aws_subnet.dev-private-subnet.*.id, count.index)
    route_table_id = element(aws_route_table.devprivate.*.id, count.index)
}