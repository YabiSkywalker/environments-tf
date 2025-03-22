output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "api_subnet_id" {
  value = aws_subnet.api_subnet.id
}

output "kafka_subnet_id" {
  value = aws_subnet.kafka_subnet.id
}

output "security_group_id" {
  value = aws_security_group.allow_tls.id
}
