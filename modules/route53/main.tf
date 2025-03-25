resource "aws_route53_record" "this" {
  for_each = var.dns_record
  zone_id = each.value.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}