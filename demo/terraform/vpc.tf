resource "aws_vpc" "nomad_remote_driver_demo" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "nomad_remote_driver_demo" {
  cidr_block = var.vpc_cidr_block
  vpc_id     = aws_vpc.nomad_remote_driver_demo.id
}

resource "aws_internet_gateway" "nomad_remote_driver_demo" {
  vpc_id = aws_vpc.nomad_remote_driver_demo.id
}

resource "aws_route_table" "nomad_remote_driver_demo" {
  vpc_id = aws_vpc.nomad_remote_driver_demo.id
}

resource "aws_route" "nomad_remote_driver_demo" {
  route_table_id         = aws_route_table.nomad_remote_driver_demo.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nomad_remote_driver_demo.id
}

resource "aws_route_table_association" "nomad_remote_driver_demo" {
  subnet_id      = aws_subnet.nomad_remote_driver_demo.id
  route_table_id = aws_route_table.nomad_remote_driver_demo.id
}

resource "aws_security_group" "nomad_remote_driver_demo" {
  vpc_id = aws_vpc.nomad_remote_driver_demo.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
