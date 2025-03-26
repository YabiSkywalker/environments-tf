output "instance_ids" {
  description = "The ID of the instances"
  value = { for k, v in aws_instance.this : k => v.id }
}

output "instance_types" {
  description = "The types of the instances"
  value = { for k, v in aws_instance.this : k => v.instance_type }
}

output "instance_security_groups" {
  description = "The security groups of the instances"
  value = { for k, v in aws_instance.this : k => v.vpc_security_group_ids }
}

output "instance_subnets" {
  description = "The subnets of the instances"
  value = { for k, v in aws_instance.this : k => v.subnet_id }
}

output "arn" {
  description = "The ARN of the instances"
  value = { for k, v in aws_instance.this : k => v.arn }
}

output "instance_state" {
  description = "The states of the instances"
  value = { for k, v in aws_instance.this : k => v.instance_state }
}


output "public-ip" {
  description = "The public IP address assigned to the instance, if applicable."
  value = { for k, v in aws_instance.this : k => v.public_ip }
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value = { for k, v in aws_instance.this : k => v.private_ip }

}

output "instance_name_tags" {
  description = "The names of the instances"
  value = { for k, v in aws_instance.this : k => v.tags }
}

output "public-dns" {
  value = { for k, v in aws_instance.this : k => v.public_dns }
}

output "public-ip-association" {
  value = { for k, v in aws_instance.this : k => v.associate_public_ip_address }
}