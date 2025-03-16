
output "security_group_id" {
  description = "The ID of the security group"
  value = aws_security_group.sg.id
}
output "public_subnet_ids" {
  description = "The ID of the subnet"
  value = values(aws_subnet.public)[*].id  
}
