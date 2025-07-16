resource "aws_instance" "dsa_instance" {
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type

  tags = {
    Name = "lab3-t1-terraform"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.dsa_instance.public_ip} > ip_dsa_instance.txt"
  }
}
