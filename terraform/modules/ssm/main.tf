resource "aws_ssm_parameter" "ecr_repository_name" {
  name        = "/CodeBuild/${var.project_name}/${var.env}/ECR_REPOSITORY_NAME"
  description = "ECR_REPOSITORY_NAME"
  type        = "String"
  value       = var.ecr_repository_name

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_hoge" {
  name        = "/${var.project_name}/${var.env}/HOGE"
  description = "HOGE"
  type        = "SecureString"
  value       = var.env_hoge

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "docker_user" {
  name        = "/CodeBuild/DOCKER_USER"
  description = "HOGE"
  type        = "String"
  value       = var.docker_user

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "docker_token" {
  name        = "/CodeBuild/DOCKER_TOKEN"
  description = "HOGE"
  type        = "SecureString"
  value       = var.docker_token

  lifecycle {
    ignore_changes = [value]
  }
}
