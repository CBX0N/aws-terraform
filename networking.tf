resource "aws_vpc" "cbx_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "cbx_public_subnet" {
  vpc_id                  = aws_vpc.cbx_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "cbx_internet_gateway" {
  vpc_id = aws_vpc.cbx_vpc.id

  tags = {
    Name = "dev-internet-gateway"
  }
}

resource "aws_route_table" "cbx_public_route_table" {
  vpc_id = aws_vpc.cbx_vpc.id

  tags = {
    Name = "dev-public-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.cbx_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cbx_internet_gateway.id
}

resource "aws_route_table_association" "cbx_route_table_association" {
  route_table_id = aws_route_table.cbx_public_route_table.id
  subnet_id      = aws_subnet.cbx_public_subnet.id
}

resource "aws_security_group" "cbx-security-group" {
  vpc_id = aws_vpc.cbx_vpc.id
  name   = "dev-security-group"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}