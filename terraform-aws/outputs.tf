output "lb_public_ip" {
  value = aws_instance.lb.public_ip
}

output "server_a_public_ip" {
  value = aws_instance.server_a.public_ip
}

output "server_b_public_ip" {
  value = aws_instance.server_b.public_ip
}

output "zabbix_public_ip" {
  value = aws_instance.zabbix.public_ip
}

