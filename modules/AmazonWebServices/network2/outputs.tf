output "vpc-id" {
  value = aws_vpc.this.id
}

output "vpc-cidr-block" {
  value = aws_vpc.this.cidr_block
}

output "igw-ig" {
  value = aws_internet_gateway.this.id
}

output "subnet-id" {
  value = aws_subnet.this.id
}

output "route-table-id" {
  value = aws_route_table.this.id
}

output "allow-internet-sg-id" {
  value = aws_security_group.allow-internet.id
}