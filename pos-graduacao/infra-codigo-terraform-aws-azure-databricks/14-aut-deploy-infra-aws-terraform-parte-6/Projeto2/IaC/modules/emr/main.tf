# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Provisionamento dos recursos EMR

# Recurso de criação do cluster EMR
resource "aws_emr_cluster" "cluster" {
  
  # Nome do cluster
  name = var.name_emr
  
  # Versão
  release_label = "emr-7.0.0"
  
  # Aplicações
  applications  = ["Hadoop", "Spark"]

  # Proteção contra término do cluster
  termination_protection = false
  
  # Mantém o job de processamento ativo
  keep_job_flow_alive_when_no_steps = false
  
  # URI da pasta com logs
  log_uri = "s3://${var.name_bucket}/logs/"

  # Role IA do serviço
  service_role = var.service_role

  # Atributos das Instâncias EC2 do cluster
  ec2_attributes {
    instance_profile = var.instance_profile
    emr_managed_master_security_group = aws_security_group.main_security_group.id
    emr_managed_slave_security_group = aws_security_group.core_security_group.id
  }

  # Tipo de instância do Master (NÃO É GRATUITO)
  master_instance_group {
    instance_type = "m5.4xlarge"
  }

  # Tipo de instância dos workers (NÃO É GRATUITO)
  core_instance_group {
    instance_type  = "m5.2xlarge"
    instance_count = 2
  }

  # Executa o script de instalação do interpretador Python e pacotes adicionais
  bootstrap_action {
    name = "Instala pacotes python adicionais"
    path = "s3://${var.name_bucket}/scripts/bootstrap.sh"
  }

  # Passos executados no cluster

  # 1- Copia os arquivos do S3 para as instâncias EC2 do cluster. Se falhar encerra o cluster.
  # 2- Copia os arquivos de log do S3 para as instâncias EC2 do cluster. Se falhar encerra o cluster.
  # 3- Executa script Python com o processamento do job. Se falhar, mantém o cluster ativo para investigar o que causou a falha.

  step = [
    {
      name              = "Copia scripts python para maquinas EC2"
      action_on_failure = "TERMINATE_CLUSTER"

      hadoop_jar_step = [
        {
          jar        = "command-runner.jar"
          args       = ["aws", "s3", "cp", "s3://${var.name_bucket}/pipeline", "/home/hadoop/pipeline/", "--recursive"]
          main_class = ""
          properties = {}
        }
      ]
    },
    {
      name              = "Copia arquivos de log para maquinas EC2"
      action_on_failure = "TERMINATE_CLUSTER"

      hadoop_jar_step = [
        {
          jar        = "command-runner.jar"
          args       = ["aws", "s3", "cp", "s3://${var.name_bucket}/logs", "/home/hadoop/logs/", "--recursive"]
          main_class = ""
          properties = {}
        }
      ]
    },
    {
      name              = "Executa script python"
      action_on_failure = "CONTINUE"

      hadoop_jar_step = [
        {
          jar        = "command-runner.jar"
          args       = ["spark-submit", "/home/hadoop/pipeline/projeto2.py"]
          main_class = ""
          properties = {}
        }
      ]
    }
  ]

  # Arquivo de configurações do Spark
  configurations_json = <<EOF
    [
    {
    "Classification": "spark-defaults",
      "Properties": {
      "spark.pyspark.python": "/home/hadoop/conda/bin/python",
      "spark.dynamicAllocation.enabled": "true",
      "spark.network.timeout":"800s",
      "spark.executor.heartbeatInterval":"60s"
      }
    }
  ]
  EOF

}