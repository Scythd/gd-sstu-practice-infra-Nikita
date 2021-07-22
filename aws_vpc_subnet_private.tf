resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.vpc_poc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
}