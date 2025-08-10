#!/usr/bin/env bash
set -e
LB_IP=$(terraform output -raw lb_public_ip)
A_IP=$(terraform output -raw server_a_public_ip)
B_IP=$(terraform output -raw server_b_public_ip)
ZBX_IP=$(terraform output -raw zabbix_public_ip)

cat > inventory.ini <<EOF
[lb]
${LB_IP} ansible_user=ubuntu

[webservers]
${A_IP} ansible_user=ubuntu
${B_IP} ansible_user=ubuntu

[zabbix]
${ZBX_IP} ansible_user=ubuntu

[all:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa_imago
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Inventory created at $(pwd)/inventory.ini"

