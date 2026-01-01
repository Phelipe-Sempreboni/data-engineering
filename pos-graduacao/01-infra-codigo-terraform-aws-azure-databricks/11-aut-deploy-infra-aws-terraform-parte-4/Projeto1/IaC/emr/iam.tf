# AWS EMR Service, Profile e Instance Roles

# AWS EMR IAM Service Role
resource "aws_iam_role" "emr_service_role" {
  name = "${var.project}-emr-service-role-${var.environment}"
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy da Service Role
resource "aws_iam_role_policy_attachment" "emr_service_role_policy" {
  role       = aws_iam_role.emr_service_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

# AWS EC2 IAM Profile Role
resource "aws_iam_role" "emr_profile_role" {
  name = "${var.project}-emr-profile-role-${var.environment}"
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy da Profile Role
resource "aws_iam_role_policy_attachment" "emr_profile_role_policy" {
  role       = aws_iam_role.emr_profile_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "emr_ec2_instance_profile" {
  name = "${var.project}-emr-ec2-profile-${var.environment}"
  role = aws_iam_role.emr_profile_role.name
}





