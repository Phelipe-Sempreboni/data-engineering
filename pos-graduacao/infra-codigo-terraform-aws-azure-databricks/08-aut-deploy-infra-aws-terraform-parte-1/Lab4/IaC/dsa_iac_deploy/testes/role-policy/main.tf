provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  role        = aws_iam_role.ec2_s3_access_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}

# Example IAM role resource (add this if you don't have an IAM role defined)
#resource "aws_iam_role" "example_role" {
 # name = "example_role"

  #assume_role_policy = jsonencode({
   # Version = "2012-10-17",
    #Statement = [{
     # Action = "sts:AssumeRole",
      #Effect = "Allow",
      #Principal = {
       # Service = "ec2.amazonaws.com"
      #}
    #}]
  #})
#}

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