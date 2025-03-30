variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
}

variable "alb_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "route53_record_fqdn" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "virginia_cert_arn" {
  type = string
}
