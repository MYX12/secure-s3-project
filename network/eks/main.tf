resource "aws_eks_cluster" "this" {
    name = var.cluster_name
    role_arn = var.cluster_role_arn

    vpc_config {
        subnet_ids = var.subnet_ids
    }

    version = "1.27"
}

resource "aws_eks_node_group" "this" {
    cluster_name = aws_eks_cluster.this.name
    node_group_name = "project4-node-group"
    node_role_arn = var.node_group_role_arn
    subnet_ids = var.subnet_ids

    scaling_config {
        desired_size = 2
        max_size = 2
        min_size = 1
    }

    instance_types  = ["t2.micro"]

    depends_on = [aws_eks_cluster.this]
}