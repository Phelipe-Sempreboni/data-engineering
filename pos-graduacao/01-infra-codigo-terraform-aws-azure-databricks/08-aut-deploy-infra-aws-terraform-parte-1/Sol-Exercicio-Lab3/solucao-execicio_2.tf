provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "sg_permite_http_web" {
  
  name = "sg_permite_http_web"
  
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

}

variable "web_servers" {
  description = "Configuração dos servidores web"
  type = map(object({
    name = string
  }))
  default = {
    "server1" = {
      name = "Server1"
    },
    "server2" = {
      name = "Server2"
    },
    "server3" = {
      name = "Server3"
    }
  }
}

resource "aws_instance" "web_server" {
  
  for_each = var.web_servers

    ami           = "ami-0a0d9cf81c479446a" 
  
    instance_type = "t2.micro"

    vpc_security_group_ids = [aws_security_group.sg_permite_http_web.id]

    tags = {
      Name = each.value.name
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo bash -c 'echo Criando o Web Server com Terraform na DSA > /var/www/html/index.html'
                EOF
}


