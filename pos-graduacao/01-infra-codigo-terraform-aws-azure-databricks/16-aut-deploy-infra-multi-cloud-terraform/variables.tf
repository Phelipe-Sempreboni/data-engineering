# Projeto 4 - Deploy Multi-Cloud com AWS e Azure usando Terraform

# Prefixo para os nomes de recursos
variable "name" {
  description = "Variável usada para prefixo em nome de recurso"
  type        = string
  default     = "dsap4"
}

## Variáveis para AWS

# Declaração da variável para CIDR block da primeira subnet pública na AWS
variable "aws_public_subnet_cidr_1" {
  type        = string                                      # Tipo da variável é string
  description = "CIDR block para a primeira public subnet"  # Descrição da variável
  default     = "10.0.10.0/24"                              # Valor padrão para o CIDR block
}

# Declaração da variável para CIDR block da segunda subnet pública na AWS
variable "aws_public_subnet_cidr_2" {
  type        = string                                     # Tipo da variável é string
  description = "CIDR block para a segunda public subnet"  # Descrição da variável
  default     = "10.0.11.0/24"                             # Valor padrão para o CIDR block
}

# Declaração da variável para CIDR block da primeira subnet privada na AWS
variable "aws_private_subnet_cidr_1" {
  type        = string                                       # Tipo da variável é string
  description = "CIDR block para a primeira private subnet"  # Descrição da variável
  default     = "10.0.20.0/24"                               # Valor padrão para o CIDR block
}

# Declaração da variável para CIDR block da segunda subnet privada na AWS
variable "aws_private_subnet_cidr_2" {
  type        = string                                      # Tipo da variável é string
  description = "CIDR block para a segunda private subnet"  # Descrição da variável
  default     = "10.0.21.0/24"                              # Valor padrão para o CIDR block
}

# Declaração da variável para zona de disponibilidade da primeira subnet na AWS
variable "aws_az_1" {
  type        = string                                      # Tipo da variável é string
  description = "Availability zone para a primeira subnet"  # Descrição da variável
  default     = "us-east-1a"                                # Valor padrão para a zona de disponibilidade
}

# Declaração da variável para zona de disponibilidade da segunda subnet na AWS
variable "aws_az_2" {
  type        = string                                     # Tipo da variável é string
  description = "Availability zone para a segunda subnet"  # Descrição da variável
  default     = "us-east-1b"                               # Valor padrão para a zona de disponibilidade
}

## Variáveis para Azure

# Declaração da variável para a localidade do grupo de recursos no Azure
variable "resource_group_location" {
  type        = string                           # Tipo da variável é string
  default     = "eastus"                         # Valor padrão para a localidade
  description = "Localidade do resource group."  # Descrição da variável
}
