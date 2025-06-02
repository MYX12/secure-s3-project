terraform {
  backend "s3" {
    bucket         = "terra-form-bucket-199903"
    key            = "terraform/project3/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}