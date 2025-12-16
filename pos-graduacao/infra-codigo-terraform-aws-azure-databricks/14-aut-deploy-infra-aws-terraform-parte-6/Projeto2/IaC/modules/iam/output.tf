# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Output do IAM

output "service_role" {
  value = aws_iam_role.iam_emr_service_role.arn
}

output "instance_profile" {
  value = aws_iam_instance_profile.emr_profile.arn
}