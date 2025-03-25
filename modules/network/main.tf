resource "aws_vpc" "this" {
  for_each = var.vpc
  cidr_block = each.value.cidr_block

  tags = merge({
    Name = each.key
  },
  each.value.tags)
}

resource "aws_subnet" "this" {
  for_each = var.subnets
  vpc_id     = each.value.vpc_id
  cidr_block = each.value.cidr_block

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
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol

}




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