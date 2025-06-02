variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed for egress"
  type        = list(string)
}
