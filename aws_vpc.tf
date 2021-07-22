/* VPC creation */
resource "aws_vpc" "vpc_poc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

/* Internet gateway for the public subnets */
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_poc.id
}
