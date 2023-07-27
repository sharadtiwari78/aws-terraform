#codecommit outputs
output "repository_id" {
  value = module.codecommit.repository_id
}
output "repository_arn" {
  value = module.codecommit.repository_arn
}
output "repository_http_url" {
  value = module.codecommit.repository_http_url
}

output "repository_ssh_url" {
  value = module.codecommit.repository_ssh_url
}