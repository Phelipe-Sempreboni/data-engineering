# Configuração da chave de segurança para acesso via SSH

# Variáveis
variable "project" {}
variable "environment" {}

# Algoritmo de criptografia da chave privada
resource "tls_private_key" "ssh_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

# local_file da chave privada
resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_private_key.private_key_pem
  filename = "generated/ssh/deployer"
}

# local_file da chave pública
resource "local_file" "ssh_public_key" {
  content  = tls_private_key.ssh_private_key.public_key_openssh
  filename = "generated/ssh/deployer.pub"
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project}-${var.environment}"
  public_key = tls_private_key.ssh_private_key.public_key_openssh
}

output "deployer_key_name" {
  value = aws_key_pair.deployer.key_name
}

output "deployer_key_pem" {
  value = tls_private_key.ssh_private_key.private_key_pem
}
