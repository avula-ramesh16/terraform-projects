variable "vpc_id" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "key_name" {}
variable "instance_type" {
  default = "t3.micro"
}