# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Grupos de Segurança

# Definição do recurso de grupo de segurança para o nó principal do EMR
resource "aws_security_group" "main_security_group" {
  
  # Nome do grupo de segurança
  name = "dsa-emr-main-security-group-p2"
  
  # Descrição do grupo de segurança
  description = "Allow inbound traffic for EMR main node."

  # Opção para revogar regras de segurança ao deletar o grupo de segurança
  revoke_rules_on_delete = true

  # Regra de entrada para permitir tráfego SSH (porta 22) de qualquer lugar
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra de saída para permitir todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Definição do recurso de grupo de segurança para os nós core (workers) do EMR
resource "aws_security_group" "core_security_group" {
  
  # Nome do grupo de segurança
  name = "dsa-emr-core-security-group-p2"
  
  # Descrição do grupo de segurança
  description = "Allow inbound outbound traffic for EMR core nodes."

  # Opção para revogar regras de segurança ao deletar o grupo de segurança
  revoke_rules_on_delete = true

  # Regra de entrada para permitir todo o tráfego de entrada dentro do próprio grupo de segurança
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  # Regra de saída para permitir todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
