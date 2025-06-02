variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "sg_id" {
  description = "The security group ID"
  type        = string
}

variable "key_name" {
  description = "The key pair name to use for SSH access"
  type        = string
}