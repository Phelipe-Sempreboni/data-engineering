# Define Security Group usando o módulo terraform-aws-modules/security-group/aws 
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
module "container-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  # Define o nome do Security Group e associa com a VPC
  # Este é o grupo do serviço de container
  name   = "${var.project_name}-${var.env}-ecs-sg"
  vpc_id = module.vpc.vpc_id

  # Configura regras de ingress e egress para o Security Group
  ingress_with_cidr_blocks = [
    {
      from_port   = var.container_port
      to_port     = var.container_port
      protocol    = "tcp"
      description = "con sg ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]

  # Tag para o Security Group
  tags = {
    Name = "${var.project_name}-${var.env}-ecs-sg"
  }
}

# Define ALB Group usando o módulo terraform-aws-modules/security-group/aws
module "alb-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  # Define o nome do Security Group e associa com a VPC
  # Este é o grupo do ALB
  name   = "${var.project_name}-${var.env}-alb-sg"
  vpc_id = module.vpc.vpc_id

  # Configura regras de ingress e egress para o Security Group
  ingress_with_cidr_blocks = [
    {
      from_port   = var.alb_sg_port
      to_port     = var.alb_sg_port
      protocol    = "tcp"
      description = "elb sg port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]

  # Tag
  tags = {
    Name = "${var.project_name}-${var.env}-alb-sg"
  }
}