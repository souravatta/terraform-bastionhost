output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "bastion_security_id" {
  value = aws_security_group.allow_bastion_internet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "vpc_id" {
  value = aws_vpc.demo.id
}
