resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = var.vpc_tag
  }
}

resource "aws_subnet" "api_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.0/25"

  tags = {
    Name = var.api_subnet_tag
  }
}

resource "aws_subnet" "kafka_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.128/25"

  tags = {
    Name = var.kafka_subnet_tag
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = var.security_group_tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_443_ipv4_in" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_ipv4_in" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}