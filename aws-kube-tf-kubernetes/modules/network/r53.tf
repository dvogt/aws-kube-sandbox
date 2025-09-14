
data "aws_route53_zone" "k8s_controller" {
  name         = var.controller_hosted_zone 
  private_zone = false
}

# A record (IPv4)
resource "aws_route53_record" "a_record" {
  zone_id         = data.aws_route53_zone.k8s_controller.zone_id
  name            = var.controller_r53_record
  type            = "A"
  ttl             = var.controller_r53_ttl
  records       =  [var.controller_ipv4]
  allow_overwrite = true
}

# AAAA record (IPv6) — created only if at least one IPv6 is provided
resource "aws_route53_record" "aaaa_record" {
  # for_each        = length(var.controller_ipv6) > 0 ? { for ip in var.controller_ipv6 : ip => ip } : {}
  zone_id         = data.aws_route53_zone.k8s_controller.zone_id
  name            = var.controller_r53_record
  type            = "AAAA"
  ttl             = var.controller_r53_ttl
  records         = var.controller_ipv6
  allow_overwrite = true
} 