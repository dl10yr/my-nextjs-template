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

variable "private_subnet_a_id" {
  type = string
}

variable "private_subnet_c_id" {
  type = string
}

variable "public_subnet_a_id" {
  type = string
}

variable "public_subnet_c_id" {
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

variable "aws_ssm_parameter_env_database_url_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_private_key_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_client_email_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_project_id_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_api_key_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_auth_domain_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_storage_bucket_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_messaging_sender_id_arn" {
  type = string
}

variable "aws_ssm_parameter_env_firebase_app_id_arn" {
  type = string
}
