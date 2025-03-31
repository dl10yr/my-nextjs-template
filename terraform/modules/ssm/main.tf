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

resource "aws_ssm_parameter" "env_database_url" {
  name        = "/${var.project_name}/${var.env}/DATABASE_URL"
  description = "Database URL"
  type        = "SecureString"
  value       = var.env_database_url

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_private_key" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_PRIVATE_KEY"
  description = "Firebase Private Key"
  type        = "SecureString"
  value       = var.env_firebase_private_key

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_client_email" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_CLIENT_EMAIL"
  description = "Firebase Client Email"
  type        = "SecureString"
  value       = var.env_firebase_client_email

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_project_id" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_PROJECT_ID"
  description = "Firebase Project ID"
  type        = "SecureString"
  value       = var.env_firebase_project_id

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_api_key" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_API_KEY"
  description = "Firebase API Key"
  type        = "SecureString"
  value       = var.env_firebase_api_key

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_auth_domain" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_AUTH_DOMAIN"
  description = "Firebase Auth Domain"
  type        = "SecureString"
  value       = var.env_firebase_auth_domain

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_storage_bucket" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_STORAGE_BUCKET"
  description = "Firebase Storage Bucket"
  type        = "SecureString"
  value       = var.env_firebase_storage_bucket

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_messaging_sender_id" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_MESSAGING_SENDER_ID"
  description = "Firebase Messaging Sender ID"
  type        = "SecureString"
  value       = var.env_firebase_messaging_sender_id

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "env_firebase_app_id" {
  name        = "/${var.project_name}/${var.env}/FIREBASE_APP_ID"
  description = "Firebase App ID"
  type        = "SecureString"
  value       = var.env_firebase_app_id

  lifecycle {
    ignore_changes = [value]
  }
}
