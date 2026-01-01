# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Variáveis do S3

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
}

variable "files_data" {
  type        = string
  description = "Pasta de onde os dados serão obtidos"
}

variable "files_bash" {
  type        = string
  description = "Pasta de onde os scripts bash serão obtidos"
}