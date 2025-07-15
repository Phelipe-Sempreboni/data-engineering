resource "aws_security_group" "permite_ssh_2" {
  
  name = "permite_ssh_2"
  
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

  vpc_security_group_ids = [aws_security_group.permite_ssh_2.id]
  
  key_name = "dsa-lab3"

  tags = {
    Name = "lab3-t4-terraform"
  }

  provisioner "file" {
    source      = "dsa_script.sh"
    destination = "/tmp/dsa_script.sh"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("dsa-lab3.pem")
      host     = self.public_ip
    }
  }

  provisioner "remote-exec" {
    
    inline = ["chmod +x /tmp/dsa_script.sh", "/tmp/dsa_script.sh"]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("dsa-lab3.pem")
      host     = self.public_ip
    }
  }
}
