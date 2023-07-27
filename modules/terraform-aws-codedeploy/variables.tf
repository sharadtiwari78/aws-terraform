variable "environment" {
  type = string
}
variable "application_name" {
  type        = string
  description = "codedeploy application name for preprod"
}
variable "deployment_group_name" {
  type        = string
  description = "deployment group name for preprod codedeploy"
}
variable "trigger_events" {
  type        = list(string)
  description = "trigger events"
}
variable "trigger_name" {
  type        = string
  description = "trigger name"
}
variable "sns_topic_name" {
  type        = string
  description = "sns topic for preprod codedeploy notification status"
}
variable "auto_rollback_configuration_event" {
  type        = list(string)
  description = "auto rollback configuration event"
}
variable "ec2_tag_filter_key" {
  type        = string
  description = "ec2 tag filter key"
}
variable "ec2_tag_filter_type" {
  type        = string
  description = "ec2 tag filter type"
}
variable "ec2_tag_filter_value" {
  type        = string
  description = "ec2 tag filter value"
}
variable "minimum_healthy_hosts_type" {
  type        = string
  description = "minimum healthy hosts type"
}
variable "minimum_healthy_hosts_value" {
  type        = number
  description = "minimum healthy hosts value"
}
variable "topic_subscription_protocol" {
  type        = string
  description = "sns topic subscription protocol"
}
variable "deployment_config_name" {
  type        = string
  description = "deployment config name"
}
