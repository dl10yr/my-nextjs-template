resource "aws_cloudwatch_log_group" "nextjs" {
  name              = "/ecs/${var.project_name}/${var.env}/nextjs"
  retention_in_days = 30
}
