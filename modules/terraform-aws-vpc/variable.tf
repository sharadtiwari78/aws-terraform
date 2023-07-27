# Define variables
variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  description = "vpc 01 cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "db_subnet" {
  description = "A list of db subnets inside the VPC"
  type        = list(string)
  default     = []
}

# Public Network acl rules
variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"
    type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })

  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"
  type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })
  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}

# private Network acl rules
variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
    type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })

  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}

variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
    type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })

  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}

variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {}
}

# database acl rules
variable "database_inbound_acl_rules" {
  description = "Database subnets inbound network ACL rules"
    type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })

  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}

variable "database_outbound_acl_rules" {
  description = "Database subnets outbound network ACL rules"
    type        = object({
     rule_number = number
     rule_action = string
     from_port   = number
     to_port     = number
     protocol   = string
     cidr_block = string
  })

  default = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
}
