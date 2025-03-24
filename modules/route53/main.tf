resource "aws_route53_zone" "this" {
  name = var.route53_zone_name
}

resource "aws_route53domains_registered_domain" "this" {
  domain_name = var.route53_domain_name

  name_server {
    name = "ns-1026.awsdns-00.org"
  }

  name_server {
    name = "ns-1923.awsdns-48.co.uk"
  }

  name_server {
    name = "ns-409.awsdns-51.com"
  }

    name_server {
    name = "ns-533.awsdns-02.net"
  }

  tags = {

  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.this.id
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}