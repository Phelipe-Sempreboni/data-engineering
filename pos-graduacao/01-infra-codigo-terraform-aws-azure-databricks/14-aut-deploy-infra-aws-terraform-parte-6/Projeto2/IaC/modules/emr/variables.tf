# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Variáveis EMR

variable "name_emr" {
  type        = string
  description = "Nome do cluster EMR"
}

variable "name_bucket" {
  type        = string
  description = "Nome do bucket"
}

variable "instance_profile" {}

variable "service_role" {}
