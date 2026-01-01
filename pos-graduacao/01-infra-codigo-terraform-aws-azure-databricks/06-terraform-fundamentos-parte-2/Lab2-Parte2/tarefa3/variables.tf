variable "region" {
  description = "A região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "O tipo de instância EC2 a ser utilizado"
  type        = string
  default     = "t2.micro"
}

variable "vpc_ids" {
  description = "IDs das VPCs onde as instâncias EC2 serão criadas"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets para as instâncias EC2 em cada VPC"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
  type        = string
}
