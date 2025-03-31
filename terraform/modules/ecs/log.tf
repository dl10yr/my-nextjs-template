resource "aws_cloudwatch_log_group" "ecs_nextjs_log_group" {
  name              = "/ecs/${var.project_name}/${var.env}/nextjs"
  retention_in_days = 30
}
