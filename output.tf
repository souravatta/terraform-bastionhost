output "public_instance_ip" {
  value = aws_instance.privateInstance.public_ip
}
