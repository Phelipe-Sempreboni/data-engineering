# Projeto 5 - Databricks Cluster Deploy com Terraform Para Processamento Distribuído

variable "job_name" {
  description = "Nome do job."
  type        = string
  default     = "DSA Job"
}

variable "task_key" {
  description = "Nome da tarefa."
  type        = string
  default     = "dsa_p5_task"
}

resource "databricks_job" "dsa_job" {
  
  name = var.job_name
  
  task {
    task_key = var.task_key
    existing_cluster_id = databricks_cluster.dsa_cluster.cluster_id
    
    notebook_task {
      notebook_path = databricks_notebook.dsa_notebook.path
    }
  }
  
  email_notifications {
    on_success = [ data.databricks_current_user.me.user_name ]
    on_failure = [ data.databricks_current_user.me.user_name ]
  }
}

output "job_url" {
  value = databricks_job.dsa_job.url
}
