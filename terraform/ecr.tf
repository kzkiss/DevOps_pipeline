#Create ECR repository
resource "aws_ecr_repository" "api" {
  name                 = "lw-devops-pipeline"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "lw-devops-pipeline"
    Environment = "dev"
  }
}