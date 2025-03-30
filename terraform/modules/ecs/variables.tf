variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "fargate_cpu" {
  type = number
}

variable "fargate_memory" {
  type = number
}

variable "ecr_repo_url" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "aws_lb_target_group_alb_arn" {
  type = string
}

variable "aws_security_group_alb_id" {
  type = string
}

variable "ssm_parameter_access_policy_arn" {
  type = string
}

variable "aws_ssm_parameter_env_hoge_arn" {
  type = string
}
