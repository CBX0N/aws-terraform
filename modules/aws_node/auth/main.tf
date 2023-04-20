resource "aws_key_pair" "cbx-auth" {
  key_name   = "${var.environment}-${var.key_name}"
  public_key = file("${var.identity_file}.pub")
}