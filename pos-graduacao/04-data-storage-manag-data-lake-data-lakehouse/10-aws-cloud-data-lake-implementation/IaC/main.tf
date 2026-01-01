# Define o provedor AWS e a região
provider "aws" {
  region = "us-east-2"  
}

# Criando um bucket S3 para o Data Lake
resource "aws_s3_bucket" "data_lake" {

  bucket = "data-lake-bucket-890582101704"

  # Provisão local: Executa um script de upload para o Data Lake
  provisioner "local-exec" {
    command = "${path.module}/upload_to_data_lake.sh"
  }

  # Provisão local: Remove o conteúdo do bucket ao destruir o recurso
  provisioner "local-exec" {
    when    = destroy
    command = "aws s3 rm s3://data-lake-bucket-890582101704 --recursive"
  }

  # Tags associadas ao bucket
  tags = {
    Name        = "Data Lake Bucket"
    Environment = "Lab3"
  }
}

# Políticas de acesso ao bucket
resource "aws_s3_bucket_policy" "data_lake_policy" {

  bucket = aws_s3_bucket.data_lake.bucket

  # Definição da política em JSON
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.data_lake.arn}",
          "${aws_s3_bucket.data_lake.arn}/*"
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "192.0.2.0/24"
          }
        }
      }
    ]
  })
}

# Criando uma role IAM para acesso ao Data Lake
resource "aws_iam_role" "data_lake_role" {

  name = "data-lake-role"

  # Política AssumeRole em formato JSON
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Associa a política à role
resource "aws_iam_role_policy" "data_lake_policy_attachment" {
  
  role = aws_iam_role.data_lake_role.id

  # Definição da política em JSON
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.data_lake.arn}",
          "${aws_s3_bucket.data_lake.arn}/*"
        ]
      }
    ]
  })
}

# Saída do bucket name
output "bucket_name" {
  value = aws_s3_bucket.data_lake.bucket
}

# Saída da ARN da role IAM
output "iam_role_arn" {
  value = aws_iam_role.data_lake_role.arn
}
