module "codecommit" {
  source           = "../../modules/terraform-aws-codecommit"
  repository_name  = "demo-repo"
  repo_description = "demo"
  default_branch   = "main"
}
