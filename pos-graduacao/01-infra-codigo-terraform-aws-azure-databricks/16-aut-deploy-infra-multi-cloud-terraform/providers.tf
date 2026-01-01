# Projeto 4 - AWS e Azure Multi-Cloud Deploy com Terraform

# Configura a versão do Terraform exigida para executar este script
terraform {
  required_version = ">= 1.6"

  # Declaração de provedores necessários
  required_providers {
    # Define o provedor Azure RM e a versão mínima necessária
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.99.0"
    }
    # Define o provedor AWS e a versão mínima necessária
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.45.0"
    }
  }
}

# Configura o provedor Azure Resource Manager
provider "azurerm" {
  features {} # Necessário, mas sem funcionalidades específicas configuradas
}

# Configura o provedor AWS
provider "aws" {
  region = "us-east-1"  # Região do provedor AWS
}
