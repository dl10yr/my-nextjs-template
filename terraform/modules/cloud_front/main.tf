resource "aws_cloudfront_distribution" "cf" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project_name}-${var.env}-cloudfront-distribution"
  price_class     = "PriceClass_All"

  origin {
    domain_name = var.route53_record_fqdn
    origin_id   = var.alb_name

    custom_origin_config {
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      http_port              = "80"
      https_port             = "443"
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    target_origin_id       = var.alb_name
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = ["dev.${var.domain}"]

  viewer_certificate {
    acm_certificate_arn      = var.virginia_cert_arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_route53_record" "route53_cloudfront" {
  zone_id = var.route53_zone_id
  name    = "dev.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}
