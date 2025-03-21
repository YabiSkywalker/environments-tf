output "instance_ids" {
  description = "The ID of the instances"
  value = { for k, v in aws_instance.this : k => v.id }
}

output "arn" {
  description = "The ARN of the instances"
  value = { for k, v in aws_instance.this : k => v.arn }
}

output "instance_state" {
  description = "The states of the instances"
  value = { for k, v in aws_instance.this : k => v.instance_state }
}


output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  value = { for k, v in aws_instance.this : k => v.public_ip }
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value = { for k, v in aws_instance.this : k => v.private_ip }

}




