output "ecr_repository_url" {
  value = aws_ecr_repository.api.repository_url
}


#output public IP
output "instance_ip" {
  value = aws_instance.api.public_ip
}

#output for github actions role ARN
output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}