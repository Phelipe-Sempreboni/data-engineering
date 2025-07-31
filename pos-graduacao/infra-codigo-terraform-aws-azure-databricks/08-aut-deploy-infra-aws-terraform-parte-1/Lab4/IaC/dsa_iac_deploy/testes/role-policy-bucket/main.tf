provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "dsa_bucket_flask" {
  bucket = "sirius-hub-tests" 

  tags = {
    Name        = "DSA Bucket"
    Environment = "Lab4"
  }

  provisioner "local-exec" {
    command = "${path.module}/upload_to_s3.sh"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws s3 rm s3://sirius-hub-tests --recursive"
  }
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  role        = aws_iam_role.ec2_s3_access_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "Statement1",
        Principal: {},
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          #"arn:aws:s3:::sirius-hub-tests",
          #"arn:aws:s3:::sirius-hub-tests/*"
          #"arn:aws:s3:::*",
          #"arn:aws:s3:::*/*"
          "${aws_s3_bucket.dsa_bucket_flask.arn}/*",
          "${aws_s3_bucket.dsa_bucket_flask.arn}"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "ec2_s3_access_role" {
  
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}