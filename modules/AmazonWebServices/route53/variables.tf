variable "dns_record" {
  description = "domain name servers"
  type = map(object({
    zone_id = string
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
}