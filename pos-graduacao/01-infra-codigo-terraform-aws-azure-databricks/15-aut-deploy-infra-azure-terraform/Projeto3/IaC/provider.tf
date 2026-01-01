# Início da configuração do bloco Terraform
terraform {
  
  # Especifica os provedores necessários
  required_providers {
    
    # Provedor AzureRM da HashiCorp
    azurerm = {
      
      # Fonte e versão do provedor
      source  = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
  }
}

# Configuração do provedor AzureRM
provider "azurerm" {
  
  # Habilita recursos e funcionalidades padrão
  features {}
}
