

variable "instances" {
 description = "EC2 config variable map"
 type = map(object({
   instance_type = string
   ami_id        = string
   tags          = map(string)
 }))
}