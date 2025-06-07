provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terra-form-bucket-199903"
  acl    = "private"
  tags = {
    Name        = "Terraform state bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

module "vpc" {
    source = "./network/vpc"
    cidr_block= "10.0.0.0/16"
    name = "project3-main-vpc"
}

module "subnet1"{
    source = "./network/subnet"
    vpc_id = module.vpc.vpc_id
    public_subnet_cidr = "10.0.11.0/24"
    private_subnet_cidr = "10.0.12.0/24"
    availability_zone = "ap-southeast-1a"
}

module "subnet2"{
    source = "./network/subnet"
    vpc_id = module.vpc.vpc_id
    public_subnet_cidr = "10.0.13.0/24"
    private_subnet_cidr = "10.0.14.0/24"
    availability_zone = "ap-southeast-1b"
}




module "internet_gateway" {
  source = "./network/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name = "project3-igw"
}


# 公共子网 1A
module "public_route_table_1a" {
  source    = "./network/route_table"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.internet_gateway.igw_id
  subnet_id = module.subnet1.public_subnet_id
  name      = "public-rt-1a"
}

# 公共子网 1B
module "public_route_table_1b" {
  source    = "./network/route_table"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.internet_gateway.igw_id
  subnet_id = module.subnet2.public_subnet_id
  name      = "public-rt-1b"
}

# 私有子网（可只绑定 subnet1）
module "private_route_table" {
  source    = "./network/route_table"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.internet_gateway.igw_id
  subnet_id = module.subnet1.private_subnet_id
  name      = "private-rt"
}
module "security_group" {
  source              = "./network/security_group"
  vpc_id              = module.vpc.vpc_id
  name                = "web-sg"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

module "ec2_instance" {
  source        = "./network/ec2"
  ami_id        = "ami-0afc7fe9be84307e4"        # 这是 Amazon Linux 2 的公共 AMI，可按需替换
  instance_type = "t2.micro"
  subnet_id     = module.subnet1.public_subnet_id
  sg_id         = module.security_group.sg_id
  key_name      = "my-ec2-keypair"           # 替换成你创建的 key pair 名称
}


module "eks_iam_role"{
  source =  "./network/eks_iam_role"
}

module "eks_iam_node_group_role"{
  source = "./network/eks_iam_node_group_role"
}



module "eks" {
  source = "./network/eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.subnet1.public_subnet_id,
                module.subnet2.public_subnet_id
  ]
  cluster_name = "project4-eks-cluster"
  cluster_role_arn = module.eks_iam_role.eks_cluster_role_arn
  node_group_role_arn = module.eks_iam_node_group_role.eks_node_group_arn
  
  }