# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Script de Definição de Variáveis

variable "name_bucket" {
  type        = string
  description = "Nome do bucket"
}

variable "versioning_bucket" {
  type        = string
  description = "Define se o versionamento do bucket estará habilitado"
}

variable "files_bucket" {
  type        = string
  description = "Pasta de onde os scripts python serão obtidos para o processamento"
  default     = "./pipeline"
}

variable "files_data" {
  type        = string
  description = "Pasta de onde os dados serão obtidos"
  default     = "./dados"
}

variable "files_bash" {
  type        = string
  description = "Pasta de onde os scripts bash serão obtidos"
  default     = "./scripts"
}

variable "name_emr" {
  type        = string
  description = "Nome do cluster EMR"
}
