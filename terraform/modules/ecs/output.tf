output "ecs_service_name" {
  value = aws_ecs_service.nextjs.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
