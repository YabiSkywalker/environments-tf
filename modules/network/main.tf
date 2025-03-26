resource "aws_vpc" "this" {
  for_each = var.vpc
  cidr_block = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}

resource "aws_subnet" "this" {
  for_each = var.subnets
  vpc_id                  = each.value.vpc_id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}


resource "aws_security_group" "this" {
  for_each      = var.security_group
  name          = each.value.name
  description   = each.value.description
  vpc_id        = each.value.vpc_id

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}


resource "aws_security_group_rule" "this" {
  for_each = var.security_group_rule
  type              = each.value.type
  security_group_id = each.value.security_group_id
  cidr_blocks       = each.value.cidr_block
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol

}

resource "aws_internet_gateway" "this" {
  for_each = var.igw
  vpc_id   = each.value.vpc_id

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}

resource "aws_route_table" "this" {
  for_each = var.route-table

  vpc_id = each.value.vpc_id

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}

resource "aws_route" "this" {
  for_each = var.route
  route_table_id            = each.value.route_table_id
  gateway_id                = each.value.gateway_id
  destination_cidr_block    = each.value.destination_cidr_block
}

resource "aws_route_table_association" "this-subnet" {
  for_each = var.route-association
  subnet_id      = each.value.subnet_id
  gateway_id     = each.value.gateway_id
  route_table_id = each.value.route_table_id
}




#resource "aws_internet_gateway_attachment" "this" {
 # for_each = var.igw_attachment
  #internet_gateway_id = each.value.internet_gateway_id
  #vpc_id              = each.value.vpc_id
#}


/*

resource "aws_subnet" "api_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.0/25"

  tags = merge({
    name = var.api_subnet_tag
  })
}

resource "aws_subnet" "kafka_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.128/25"

  tags = var.kafka_subnet_tag
}

*/