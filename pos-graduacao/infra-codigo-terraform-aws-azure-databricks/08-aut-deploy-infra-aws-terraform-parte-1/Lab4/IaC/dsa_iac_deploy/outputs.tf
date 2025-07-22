output "instance_public_dns" {
  value = aws_instance.dsa_ml_api.public_dns
}
