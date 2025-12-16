# Projeto 5 - Databricks Cluster Deploy com Terraform Para Processamento Distribuído

# Obtém detalhes sobre o usuário
data "databricks_current_user" "me" {}

variable "notebook_subdirectory" {
  description = "Nome para diretório onde armazenar o notebook."
  type        = string
  default     = "DSAProjeto5"
}

variable "notebook_filename" {
  description = "Nome do notebook."
  type        = string
}

variable "notebook_language" {
  description = "Linguagem de programação do notebook."
  type        = string
}

resource "databricks_notebook" "dsa_notebook" {
  path     = "${data.databricks_current_user.me.home}/${var.notebook_subdirectory}/${var.notebook_filename}"
  language = var.notebook_language
  source   = "./${var.notebook_filename}"
}

output "notebook_url" {
 value = databricks_notebook.dsa_notebook.url
}
