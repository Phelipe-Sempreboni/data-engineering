# Criação do Cluster EMR

# Variáveis

# Definição da variável 'project'
variable "project" { }

# Definição da variável 'environment'
variable "environment" { }

# Definição da variável 'tags'
variable "tags" { }

# Definição da variável 'key_name'
variable "key_name" { }

# Definição da variável 'vpc_id'
variable "vpc_id" { }

# Definição da variável 'public_subnet'
variable "public_subnet" { }

# Definição da variável 'additional_security_group_id'
variable "additional_security_group_id" { }

# Definição da variável 'release_label'
variable "release_label" { }

# Definição da variável 'applications'
variable "applications" { }

# Definição da variável 'main_instance_type'
variable "main_instance_type" { }

# Definição da variável 'core_instance_type'
variable "core_instance_type" { }

# Definição da variável 'core_instance_count'
variable "core_instance_count" { }

# Definição da variável 'core_instance_ebs_volume_size' com valor padrão
variable "core_instance_ebs_volume_size" { default = "80" }

# Definição da variável 'security_configuration_name' com valor padrão nulo
variable "security_configuration_name" { default = null }

# Definição da variável 'log_uri' com valor padrão (substitua account-id pelo id da sua conta)
variable "log_uri" { default = "s3://dsa-projeto1-<account-id>" }

# Definição da variável 'configurations' com valor padrão nulo
variable "configurations" { default = null }

# Definição da variável 'steps' com tipo complexo e valor padrão nulo
variable "steps" {
  type = list(object(
    {
      name = string
      action_on_failure = string
      hadoop_jar_step = list(object(
        {
          args       = list(string)
          jar        = string
          main_class = string
          properties = map(string)
        }
      ))
    }
  ))
  default = null
}

# Definição da variável 'bootstrap_action' com valor padrão vazio
variable "bootstrap_action" {
  type = set(object(
    {
      name = string
      path = string
      args = list(string)
    }
  ))
  default = []
}

# Definição da variável 'kerberos_attributes' com valor padrão vazio
variable "kerberos_attributes" {
  type = set(object(
    {
      kdc_admin_password = string
      realm              = string
    }
  ))
  default = []
}

# Cria o cluster
resource "aws_emr_cluster" "emr_cluster" {
  name                   = "${var.project}-emr-cluster-${var.environment}"
  release_label          = var.release_label
  applications           = var.applications
  security_configuration = var.security_configuration_name
  service_role           = aws_iam_role.emr_service_role.arn
  log_uri                = var.log_uri
  configurations         = var.configurations
  step                   = var.steps
  tags                   = var.tags

  master_instance_group {
    instance_type  = var.main_instance_type
    instance_count = "1"
  }

  core_instance_group {
    instance_type = var.core_instance_type
    instance_count = var.core_instance_count
    ebs_config {
      size = var.core_instance_ebs_volume_size
      type = "gp2"
      volumes_per_instance = 1
    }
  }

  ec2_attributes {
    key_name = var.key_name
    subnet_id = var.public_subnet
    instance_profile = aws_iam_instance_profile.emr_ec2_instance_profile.arn
    emr_managed_master_security_group = aws_security_group.main_security_group.id
    emr_managed_slave_security_group = aws_security_group.core_security_group.id
    additional_master_security_groups = var.additional_security_group_id
    additional_slave_security_groups = var.additional_security_group_id
  }

  dynamic "bootstrap_action" {
    for_each = var.bootstrap_action
    content {
      name = bootstrap_action.value["name"]
      path = bootstrap_action.value["path"]
      args = bootstrap_action.value["args"]
    }
  }

  dynamic "kerberos_attributes" {
    for_each = var.kerberos_attributes
    content {
      realm              = kerberos_attributes.value["realm"]
      kdc_admin_password = kerberos_attributes.value["kdc_admin_password"]
    }
  }

  lifecycle {
    ignore_changes = [
      step
    ]
  }

}

# Saída
output "emr_main_address" {
  value = aws_emr_cluster.emr_cluster.master_public_dns
}
