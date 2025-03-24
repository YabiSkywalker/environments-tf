variable "route53_zone_name" {
  description = "Name of route53 hosted zone"
  type = string
}

variable "route53_domain_name" {
  description = "Name of route53 record domain name"
  type = string
}

variable "dns_record" {
  description = "domain name servers"
  type = map(object({
    zone_id = string
    name    = string
    type    = string
    ttl     = number
    records = string
  }))
}