# Projeto 4 - AWS e Azure Multi-Cloud Deploy com Terraform

# Define uma VPC na AWS com um bloco CIDR específico
resource "aws_vpc" "aws_my_vpc" {
  cidr_block = "10.0.0.0/16"  # Bloco CIDR para toda a VPC

  tags = {
    Name = "${var.name}_vpc"  # Nome da VPC, com sufixo personalizável
  }
}

# Define a primeira subnet pública na AWS
resource "aws_subnet" "aws_public_subnet_1" {
  vpc_id            = aws_vpc.aws_my_vpc.id         # Associa a subnet à VPC criada
  cidr_block        = var.aws_public_subnet_cidr_1  # Bloco CIDR para esta subnet
  availability_zone = var.aws_az_1                  # Zona de disponibilidade para a subnet

  tags = {
    Name = "${var.name}_public_subnet_1"  # Nome da subnet, com sufixo personalizável
  }
}

# Define a segunda subnet pública na AWS
resource "aws_subnet" "aws_public_subnet_2" {
  vpc_id            = aws_vpc.aws_my_vpc.id         # Associa a subnet à VPC criada
  cidr_block        = var.aws_public_subnet_cidr_2  # Bloco CIDR para esta subnet
  availability_zone = var.aws_az_2                  # Zona de disponibilidade para a subnet

  tags = {
    Name = "${var.name}_public_subnet_2"  # Nome da subnet, com sufixo personalizável
  }
}

# Define um gateway de internet para a VPC
resource "aws_internet_gateway" "aws_ig" {
  vpc_id = aws_vpc.aws_my_vpc.id  # Associa o gateway de internet à VPC

  tags = {
    Name = "${var.name}_ig"  # Nome do gateway de internet, com sufixo personalizável
  }
}

# Define uma tabela de roteamento para as subnets públicas
resource "aws_route_table" "aws_pub_rt" {
  vpc_id = aws_vpc.aws_my_vpc.id  # Associa a tabela de roteamento à VPC

  route {
    cidr_block   = "0.0.0.0/0"                     # Roteia todo o tráfego para o gateway de internet
    gateway_id   = aws_internet_gateway.aws_ig.id  # Especifica o gateway de internet
  }

  tags = {
    Name = "${var.name}_pub_rt"  # Nome da tabela de roteamento, com sufixo personalizável
  }
}

# Associa a primeira subnet pública à tabela de roteamento
resource "aws_route_table_association" "aws_pub_sub_assoc_1" {
  subnet_id      = aws_subnet.aws_public_subnet_1.id  # Subnet a ser associada
  route_table_id = aws_route_table.aws_pub_rt.id      # Tabela de roteamento para associação
}

# Associa a segunda subnet pública à tabela de roteamento
resource "aws_route_table_association" "aws_pub_sub_assoc_2" {
  subnet_id      = aws_subnet.aws_public_subnet_2.id  # Subnet a ser associada
  route_table_id = aws_route_table.aws_pub_rt.id      # Tabela de roteamento para associação
}

# Define a primeira subnet privada na AWS
resource "aws_subnet" "aws_private_subnet_1" {
  vpc_id            = aws_vpc.aws_my_vpc.id          # Associa a subnet à VPC criada
  cidr_block        = var.aws_private_subnet_cidr_1  # Bloco CIDR para esta subnet
  availability_zone = var.aws_az_1                   # Zona de disponibilidade para a subnet

  tags = {
    Name = "${var.name}_private_subnet_1"  # Nome da subnet, com sufixo personalizável
  }
}

# Define a segunda subnet privada na AWS
resource "aws_subnet" "aws_private_subnet_2" {
  vpc_id            = aws_vpc.aws_my_vpc.id          # Associa a subnet à VPC criada
  cidr_block        = var.aws_private_subnet_cidr_2  # Bloco CIDR para esta subnet
  availability_zone = var.aws_az_2                   # Zona de disponibilidade para a subnet

  tags = {
    Name = "${var.name}_private_subnet_2"  # Nome da subnet, com sufixo personalizável
  }
}

# Define um load balancer de aplicação na AWS
resource "aws_lb" "aws_alb" {
  name                 = "alb"                              # Nome do load balancer
  internal             = false                              # Define como um load balancer acessível publicamente
  load_balancer_type   = "application"                      # Tipo de load balancer
  security_groups      = [aws_security_group.aws_lb_sg.id]  # Grupos de segurança associados
  subnets              = [
    aws_subnet.aws_public_subnet_1.id,
    aws_subnet.aws_public_subnet_2.id
  ]  # Subnets associadas ao load balancer

  tags = {
    Environment = "production"  # Ambiente designado para o load balancer
  }
}

# Define um grupo de destino para o load balancer
resource "aws_lb_target_group" "aws_app_tg" {
  name     = "AppTargetGroup"  # Nome do grupo de destino
  port     = 80  # Porta para o tráfego HTTP
  protocol = "HTTP"  # Protocolo do tráfego
  vpc_id   = "${aws_vpc.aws_my_vpc.id}"  # VPC associada ao grupo de destino
}

# Define um listener para o load balancer
resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.aws_alb.arn}"  # ARN do load balancer
  port              = "80"  # Porta do listener
  protocol          = "HTTP"  # Protocolo do listener

  default_action {
    type             = "forward"  # Ação padrão para encaminhar o tráfego
    target_group_arn = "${aws_lb_target_group.aws_app_tg.arn}"  # ARN do grupo de destino
  }
}

# Define um grupo de segurança para um bastion host
resource "aws_security_group" "aws_bastion_sg" {
  name        = "BastionHostSG"  # Nome do grupo de segurança
  description = "Allow SSH"  # Descrição do grupo de segurança
  vpc_id      = aws_vpc.aws_my_vpc.id  # VPC associada ao grupo de segurança

  ingress {
    from_port   = 22  # Porta de entrada
    to_port     = 22  # Porta de saída
    protocol    = "tcp"  # Protocolo
    cidr_blocks = ["0.0.0.0/0"]  # Blocos CIDR permitidos
  }
}

# Define um grupo de segurança para o load balancer
resource "aws_security_group" "aws_lb_sg" {
  name        = "LoadBalancerSG"  # Nome do grupo de segurança
  description = "Allow HTTP Access"  # Descrição do grupo de segurança
  vpc_id      = aws_vpc.aws_my_vpc.id  # VPC associada ao grupo de segurança

  ingress {
    from_port   = 80  # Porta de entrada
    to_port     = 80  # Porta de saída
    protocol    = "tcp"  # Protocolo
    cidr_blocks = ["0.0.0.0/0"]  # Blocos CIDR permitidos
  }
}

# Define uma instância AWS para servir como servidor de aplicativos
resource "aws_instance" "dsa-app-server" {
  ami           = "ami-051f8a213df8bc089"  # AMI da instância
  instance_type = "t2.micro"  # Tipo da instância
  subnet_id     = aws_subnet.aws_public_subnet_1.id  # Subnet para a instância

  security_groups = [
    aws_security_group.aws_bastion_sg.id,
    aws_security_group.aws_lb_sg.id
  ]  # Grupos de segurança associados

  tags = {
    Name = "AppServerInstance"  # Nome da instância, com sufixo personalizável
  }
}
