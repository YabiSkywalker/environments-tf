variable "vpc-cidr-block" {
  description = "CIDR block to start off the VPC"
  type        = string
}

variable "instance-tenancy" {
  description = "Will the instances run on the same hardware?"
  type        = string
  default     = "default"
}

variable "enable-dns-hostnames" {
  description = "enable_dns_hostnames for the vpc"
  type        = bool
  default     = false
}

variable "vpc-tags" {
  description = "Tag"
  type        = map(string)
}

#variable "vpc-id-for-subnet" {
#  description = "Attach VPC id"
#  type        = string
#}

variable "subnet-cidr-block" {
  description = "CIDR block to start off the subnet"
  type        = string
}

variable "map-public-ip-on-launch" {
  description = "map_public_ip_on_launch for the subnet"
  type        = bool
  default     = false
}

variable "subnet-tags" {
  description = "Tag"
  type        = map(string)
}

#variable "igw-vpc-id" {
#  description = "Attach VPC id for the internet gateway"
#  type        = string
#}

variable "destination-cidr-block" {
  description = "CIDR block for destination of aws route"
  type        = string
}

