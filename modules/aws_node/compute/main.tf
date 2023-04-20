data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "local_file" "user_data" {
  filename = "./modules/aws_node/compute/templates/userdata.tpl"
}

resource "aws_instance" "cbx_instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = var.key_pair_id
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnet_id
  user_data              = data.local_file.user_data.content

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "${var.environment}-node"
  }

}