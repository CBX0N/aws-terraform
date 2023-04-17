resource "aws_key_pair" "cbx-auth" {
  key_name   = "cbxkey"
  public_key = file("${var.identity_file}.pub")
}