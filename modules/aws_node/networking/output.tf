output "security_group_id"{
    value = aws_security_group.cbx-security-group.id
}

output "public_subnet_id"{
    value = aws_subnet.cbx_public_subnet.id
}