terraform {
  backend "s3" {
    bucket = "terraform-state-ramesh-069"
    key = "staging/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf_locks"
  }
}

provider "aws" {
  region = "us-east-1"
}
variable "vpc_cidr" {
  
}
module "vpc" {
  source = "../../modules/vpc"

  region               = "us-east-1"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
}
variable "env" {}
variable "instance_type" {}
module "ec2" {
  source = "../../modules/ec2"
  
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  sg_id     = module.vpc.sg_id   # expose this from vpc outputs
  key_name  = "my-key-${var.env}"
  instance_type = var.instance_type
  env = var.env
}

