variable "vpc" {
  description = "VPC variable"
  type = map(object({
    cidr_block    = string
    enable_dns_hostnames  = string
    tags          = map(string)
  }))
}

variable "subnets" {
  description = "VPC subnets"
  type = map(object({
    vpc_id                  = string
    cidr_block              = string
    map_public_ip_on_launch = bool

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
    ipv6_cidr_blocks    = optional(list(string))
    from_port           = number
    to_port             = number
    protocol            = string
  }))
}

variable "igw" {
  type = map(object({
    vpc_id = string
    tags   = map(string)
  }))
}

variable "route-table" {
  type = map(object({
    vpc_id  = string
    tags        = map(string)
  }))
}

variable "route" {
  type = map(object({
    route_table_id            = string
    gateway_id                = string
    destination_cidr_block    = string
  }))
}

variable "route-association" {
  type = map(object({
      subnet_id      = optional(string)
      route_table_id = string
  }))
}



#variable "igw_attachment" {
#  type = map(object({
#    internet_gateway_id = string
#    #vpc_id              = string
#  }))
#}