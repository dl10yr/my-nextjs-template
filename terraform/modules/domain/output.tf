output "route53_record_fqdn" {
  value = aws_route53_record.route53_record.fqdn
}

output "route53_zone_id" {
  value = aws_route53_zone.route53_zone.id
}

output "virginia_cert_arn" {
  value = aws_acm_certificate.virginia_cert.arn
}