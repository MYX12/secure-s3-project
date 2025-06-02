
resource "aws_subnet" "public_subnet" {
    vpc_id = var.vpc_id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true

    tags = {
        Name = "project3-public-subnet"
    }
}

resource "aws_subnet" "private_subnet"{
    vpc_id = var.vpc_id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone
    

    tags = {
        Name = "project3-private-subnet"
    }
}