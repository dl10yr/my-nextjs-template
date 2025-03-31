resource "aws_route53_zone" "route53_zone" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name    = "${var.project_name}-${var.env}-domain"
    Project = var.project_name
    Env     = var.env
  }
}

resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.id
  name    = "${var.env}-elb.${var.domain}"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
