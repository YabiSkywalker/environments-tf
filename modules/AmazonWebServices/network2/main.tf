resource "aws_vpc" "this" {
  cidr_block            = var.vpc-cidr-block
  instance_tenancy      = var.instance-tenancy
  enable_dns_hostnames  = var.enable-dns-hostnames

  tags = var.vpc-tags
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet-cidr-block
  map_public_ip_on_launch = var.map-public-ip-on-launch

  tags = var.subnet-tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "this" {
  route_table_id          = aws_route_table.this.id
  destination_cidr_block  = var.destination-cidr-block
  gateway_id              = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  subnet_id = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_security_group" "allow-internet" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

