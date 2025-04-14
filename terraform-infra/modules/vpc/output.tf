output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_facing_subnet[*].id
}

output "private_subnet_buck_ids" {
  description = "The IDs of the private data storage subnets"
  value       = aws_subnet.private_data_storage_subnet[*].id
}
output "private_subnet_app_ids" {
  description = "The IDs of the private application subnets"
  value       = aws_subnet.private_app_subnet[*].id
}
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.nat_gw.id : null
}