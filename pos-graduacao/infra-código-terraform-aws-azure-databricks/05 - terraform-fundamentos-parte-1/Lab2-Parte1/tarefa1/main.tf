variable "instance_type" {
  description = "O tipo de instância a ser criada"
}

variable "ami" {
  description = "A Amazon Machine Image (AMI) a ser usada pela instância"
}

variable "region" {
  description = "A região AWS onde a instância será criada"
  default     = "us-east-2"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "tarefa1-terraform"
  }
}
