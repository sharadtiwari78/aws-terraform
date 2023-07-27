output "repository_id" {
  value = aws_codecommit_repository.codecommit_repository.repository_id
}
output "repository_arn" {
  value = aws_codecommit_repository.codecommit_repository.arn
}
output "repository_http_url" {
  value = aws_codecommit_repository.codecommit_repository.clone_url_http
}

output "repository_ssh_url" {
  value = aws_codecommit_repository.codecommit_repository.clone_url_ssh
}