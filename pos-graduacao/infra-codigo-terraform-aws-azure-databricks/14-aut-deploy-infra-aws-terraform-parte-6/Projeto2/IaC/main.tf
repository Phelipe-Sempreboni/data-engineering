# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Script Principal

# Módulo de Armazenamento
module "s3" {
  source            = "./modules/s3"
  name_bucket       = var.name_bucket
  versioning_bucket = var.versioning_bucket
  files_bucket      = var.files_bucket
  files_data        = var.files_data
  files_bash        = var.files_bash
}

# Módulo de Segurança
module "iam" {
  source = "./modules/iam"
}

# Módulo de Processamento
module "emr" {
  source           = "./modules/emr"
  name_emr         = var.name_emr
  name_bucket      = var.name_bucket
  instance_profile = module.iam.instance_profile
  service_role     = module.iam.service_role
}

