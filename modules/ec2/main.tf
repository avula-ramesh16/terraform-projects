
resource "aws_key_pair" "deployer" {
  key_name   = "my-key-${var.env}"
  public_key = file("my-key.pub")
}


resource "aws_instance" "my_ec2" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name

  tags = {
    Name          = "terraform-ec2"
    "Environment" = "dev"
  }

}
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

