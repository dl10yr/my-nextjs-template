output "ssm_parameter_policy_arn" {
	value = aws_iam_policy.ssm_parameter_policy.arn
}

output "ssm_parameter_env_hoge_arn" {
	value = aws_ssm_parameter.env_hoge.arn
}