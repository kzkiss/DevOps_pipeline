output "ecr_repository_url" {
  value = aws_ecr_repository.api.repository_url
}


#output public IP
output "instance_ip" {
  value = aws_instance.api.public_ip
}