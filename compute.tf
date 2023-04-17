resource "aws_instance" "cbx_instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.cbx-auth.id
  vpc_security_group_ids = [aws_security_group.cbx-security-group.id]
  subnet_id              = aws_subnet.cbx_public_subnet.id
  user_data              = file("templates/userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "$(var.environment)_node"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}_ssh_config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu"
      identityfile = var.identity_file
    })
    interpreter = ["bash", "-c"]
  }
}