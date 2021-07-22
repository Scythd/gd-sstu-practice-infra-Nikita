resource "aws_route_table" "route_gw" {
  vpc_id = aws_vpc.vpc_poc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}
resource "aws_route_table_association" "route_gw_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_gw.id
}


resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc_poc.default_route_table_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.bastion.id
  }
}
resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_vpc.vpc_poc.default_route_table_id
}

