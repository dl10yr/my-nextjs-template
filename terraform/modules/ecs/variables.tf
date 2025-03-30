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

variable "fargate_cpu" {
  description = "The amount of CPU to allocate for the Fargate task"
  type        = number
}

variable "fargate_memory" {
  description = "The amount of memory to allocate for the Fargate task"
  type        = number
}

variable "ecr_repo_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "subnet_a_id" {
  type        = string
}

variable "aws_lb_target_group_alb_arn" {
  type        = string
}

variable "aws_security_group_alb_id" {
  type        = string
}

variable "ssm_parameter_access_policy_arn" {
  type        = string
}

variable "aws_ssm_parameter_env_hoge_arn" {
  type        = string
}
