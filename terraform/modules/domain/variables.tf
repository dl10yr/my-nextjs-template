variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
}

variable "domain" {
  type = string
}

variable "alb_arn" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}
