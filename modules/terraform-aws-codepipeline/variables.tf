variable "artifact_store" {
  type        = any
  description = "artifact store type"
}
variable "codepipeline_name" {
  type        = string
  description = "codepipeline name"
}
variable "stages" {
  type = any
}
variable "environment" {
  type = string
}


