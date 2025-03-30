variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_c_id" {
  type = string
}
