resource "aws_security_group" "permite_ssh" {
  
  name = "permite_ssh"
  
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 22
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

resource "aws_instance" "dsa_instance" {
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type
  
  key_name = "dsa-lab3"

  tags = {
    Name = "lab3-t3-terraform"
  }

  provisioner "remote-exec" {
    
    inline = ["sudo yum update -y", 
              "sudo yum install httpd -y", 
              "sudo systemctl start httpd", 
              "sudo bash -c 'echo Criando o Segundo Web Server com Terraform na DSA > /var/www/html/index.html'"]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("dsa-lab3.pem")
      host     = self.public_ip
    }
  }
}
