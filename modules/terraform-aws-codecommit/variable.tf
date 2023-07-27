variable "repository_name" {
  type        = string
  description = "The name of your GIT repository" 
}
variable "repo_description" {
   type = string
   description = "the description of the GIT repository"
}

variable "default_branch" {
    type = string
    description = "the name of the default branch"

}