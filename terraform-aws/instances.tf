resource "aws_instance" "lb" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.imago_sg.id]
  tags                   = { Name = "imago-lb" }
}

resource "aws_instance" "server_a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.imago_sg.id]
  tags                   = { Name = "imago-server-a" }
}

resource "aws_instance" "server_b" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.imago_sg.id]
  tags                   = { Name = "imago-server-b" }
}

resource "aws_instance" "zabbix" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.imago_sg.id]
  tags                   = { Name = "imago-zabbix" }
}

