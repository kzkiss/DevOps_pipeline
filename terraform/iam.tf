#IAM role permission for EC2 to access ECR
resource "aws_iam_role" "ec2_role" {
  name        = "lw-devops-pipeline-ec2-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ecr_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Create instance profile for EC2 to use IAM role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "lw-devops-pipeline-ec2-profile"
  role = aws_iam_role.ec2_role.name
}


