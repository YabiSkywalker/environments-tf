variable "vpc" {
  description = "VPC variable"
  type = map(object({
    cidr_block    = string
    tags          = map(string)
  }))
}

variable "subnets" {
  description = "VPC subnets"
  type = map(object({
    vpc_id      = string
    cidr_block  = string

    tags        = map(string)
  }))
}

variable "security_group" {
  description   = "Security group variable"
  type          = map(object({
    name        = string
    description = string
    vpc_id      = string

    tags        = map(string)
  }))
}


variable "security_group_rule" {
  description           = "Security group ingress/egress rules"
  type = map(object({
    type                = string
    security_group_id   = string
    cidr_block          = list(string)
    from_port           = number
    to_port             = number
    protocol            = string
  }))
}