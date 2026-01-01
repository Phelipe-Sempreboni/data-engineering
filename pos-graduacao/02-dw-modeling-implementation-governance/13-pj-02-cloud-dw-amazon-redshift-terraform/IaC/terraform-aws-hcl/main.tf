# Configura o provedor AWS e especifica a região
provider "aws" {
  region = "us-east-2"
}

# Cria um grupo de segurança chamado "dsa_permite_http_ssh"
resource "aws_security_group" "dsa_permite_http_ssh" {
  
  # Nome do grupo de segurança
  name        = "dsa_permite_http_ssh"
  
  # Descrição do grupo de segurança
  description = "Permite trafego HTTP e SSH"

  # Configura a regra de entrada para permitir SSH
  ingress {
    
    # Porta inicial do intervalo
    from_port   = 22
    
    # Porta final do intervalo
    to_port     = 22
    
    # Protocolo utilizado
    protocol    = "tcp"
    
    # Intervalo de IPs permitidos
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Configura a regra de entrada para permitir HTTP
  ingress {
    
    # Porta inicial do intervalo
    from_port   = 80
    
    # Porta final do intervalo
    to_port     = 80
    
    # Protocolo utilizado
    protocol    = "tcp"
    
    # Intervalo de IPs permitidos
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Configura a regra de saída para permitir todo o tráfego
  egress {
    
    # Porta inicial do intervalo
    from_port   = 0
    
    # Porta final do intervalo
    to_port     = 0
    
    # Protocolo utilizado
    protocol    = "-1"
    
    # Intervalo de IPs permitidos
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cria uma instância EC2 chamada "dsa_web_server"
resource "aws_instance" "dsa_web_server" {
  
  # ID da AMI (Amazon Machine Image) do Amazon Linux 2
  ami           = "ami-0a31f06d64a91614b"
  
  # Tipo da instância
  instance_type = "t2.micro"

  # Associa o grupo de segurança à instância
  vpc_security_group_ids = [aws_security_group.dsa_permite_http_ssh.id]

  # Define as tags da instância
  tags = {
    Name = " DSA Web Server"
  }
}
