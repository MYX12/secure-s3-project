
output "igw_id" {
    description = "The ID of the internet gateway"
    value = aws_internet_gateway.this.id
}