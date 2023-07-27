resource "aws_codecommit_repository" "codecommit_repository" {
  repository_name = var.repository_name
  description     = var.repo_description
  default_branch  = var.default_branch

  tags = {
    Name = var.repository_name
  }
}