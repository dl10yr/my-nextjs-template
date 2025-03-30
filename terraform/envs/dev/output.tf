output "alb_endpoint" {
  value = module.alb.endpoint
}

output "domain_name_servers" {
  value = module.domain.name_servers
}
