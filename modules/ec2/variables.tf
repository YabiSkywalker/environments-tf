variable "instances" {
 description = "EC2 config variable map"
 type = map(object({
   ami_id                      = string
   instance_type               = string
   subnet_id                   = optional(string)
   key_name                    = string
   vpc_security_group_ids      = optional(list(string))
   associate_public_ip_address = bool
   tags                        = map(string)
 }))
}

