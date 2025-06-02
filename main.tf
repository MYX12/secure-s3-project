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

module "subnet"{
    source = "./network/subnet"
    vpc_id = module.vpc.vpc_id
    public_subnet_cidr = "10.0.1.0/24"
    private_subnet_cidr = "10.0.2.0/24"
    availability_zone = "ap-southeast-1a"
}

module "internet_gateway" {
  source = "./network/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name = "project3-igw"
}


module "public_route_table" {
  source     = "./network/route_table"
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.internet_gateway.igw_id
  subnet_id  = module.subnet.public_subnet_id
  name       = "public-rt"
}

module "private_route_table" {
  source     = "./network/route_table"
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.internet_gateway.igw_id
  subnet_id  = module.subnet.private_subnet_id
  name       = "private-rt"
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
  subnet_id     = module.subnet.public_subnet_id
  sg_id         = module.security_group.sg_id
  key_name      = "my-ec2-keypair"           # 替换成你创建的 key pair 名称
}

