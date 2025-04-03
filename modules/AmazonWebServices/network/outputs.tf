output "vpc-id" {
  value = { for k, v in aws_vpc.this : k => v.id}
}


output "subnet_id" {
  value = { for k, v in aws_subnet.this : k => v.id}
}

output "security_group_id" {
  value = { for k, v in aws_security_group.this : k => v.id }
}

output "igw_id" {
  value = { for k, v in aws_internet_gateway.this : k => v.id}
}

output "route-table-id" {
  value = { for k, v in aws_route_table.this : k => v.id}
}