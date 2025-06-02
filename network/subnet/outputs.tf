output "vpc_id"{
    value = var.vpc_id
}

output "public_subnet_id" {
    description = "The ID of the public subnet"
    value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    description = "The ID of the public subnet"
    value = aws_subnet.private_subnet.id
}