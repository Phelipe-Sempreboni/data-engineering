provider "aws" {
  region = var.region
}

resource "aws_instance" "instance_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnets[0]

  tags = {
    Name = "DSA Instance 1"
  }
}

resource "aws_instance" "instance_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnets[1]

  tags = {
    Name = " DSA Instance 2"
  }
}
