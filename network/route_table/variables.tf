variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the route table"
  type        = string
}

variable "igw_id" {
  description = "The ID of the internet gateway"
  type        = string
}

variable "name" {
  description = "Name tag for the route table"
  type        = string
}