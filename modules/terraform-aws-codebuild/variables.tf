variable "codebuild_project_name" {
  type        = string
  description = "codebuild project name"
}
variable "codebuild_timeout" {
  type        = number
  description = "codebuild timeout"
}
variable "artifacts_type" {
  type        = string
  description = "artifacts type"
}
variable "compute_type" {
  type        = string
  description = "environment compute type"
}
variable "image" {
  type        = string
  description = "environment image"
}
variable "type" {
  type        = string
  description = "environment type"
}
variable "image_pull_credentials_type" {
  type        = string
  description = "environment image pull credentials type"
}
variable "source_type" {
  type        = string
  description = "source type"
}
variable "environment_variable_name" {
  type        = string
  description = "environment variable name"
}
variable "value" {
  type        = string
  description = "environment variable value"
}
variable "buildspec" {
  type        = string
  description = "this is buildspec file for build the code"
}
variable "cloudwatch_group_name" {
  type        = string
  description = "preprod cloudwatch logs group name"
}
variable "cloudwatch_stream_name" {
  type        = string
  description = "preprod cloudwatch logs stream name"
}
variable "environment" {
  type = string
}