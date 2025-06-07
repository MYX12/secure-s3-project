variable "vpc_id" {
    description = "The ID of the VPC"
    type = string
}

variable "subnet_ids" {
    description = "A list of subnet IDs for EKS cluster"
    type = list(string)
}

variable "cluster_name"{
    description = "Name of the EKS cluster"
    type = string
}

variable "cluster_version" {
    description ="Kubernetes version"
    type = string
    default = "1.29"
}

variable "cluster_role_arn" {
    description = "IAM role ARN for the EKS Cluster"
    type = string
}

variable "node_group_role_arn" {
    description = "IAM role ARN for the EKS node group"
    type = string
}

