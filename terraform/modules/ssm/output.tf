output "ssm_parameter_policy_arn" {
  value = aws_iam_policy.ssm_parameter_policy.arn
}

output "ssm_parameter_env_hoge_arn" {
  value = aws_ssm_parameter.env_hoge.arn
}

output "ssm_parameter_env_database_url_arn" {
  value = aws_ssm_parameter.env_database_url.arn
}

output "ssm_parameter_env_firebase_private_key_arn" {
  value = aws_ssm_parameter.env_firebase_private_key.arn
}

output "ssm_parameter_env_firebase_client_email_arn" {
  value = aws_ssm_parameter.env_firebase_client_email.arn
}

output "ssm_parameter_env_firebase_project_id_arn" {
  value = aws_ssm_parameter.env_firebase_project_id.arn
}

output "ssm_parameter_env_firebase_api_key_arn" {
  value = aws_ssm_parameter.env_firebase_api_key.arn
}

output "ssm_parameter_env_firebase_auth_domain_arn" {
  value = aws_ssm_parameter.env_firebase_auth_domain.arn
}

output "ssm_parameter_env_firebase_storage_bucket_arn" {
  value = aws_ssm_parameter.env_firebase_storage_bucket.arn
}

output "ssm_parameter_env_firebase_messaging_sender_id_arn" {
  value = aws_ssm_parameter.env_firebase_messaging_sender_id.arn
}

output "ssm_parameter_env_firebase_app_id_arn" {
  value = aws_ssm_parameter.env_firebase_app_id.arn
}
