module "loadbalancer" {
  source = "./aws_loadbalancer_module"

  subnet        = aws_subnet.private.id
  instance_sg   = aws_security_group.private.id
  vpc           = aws_vpc.vpc_poc.id
  vpc_cidr      = aws_vpc.vpc_poc.cidr_block
  public_subnet = aws_subnet.public.id
  key_name      = aws_key_pair.bastion-key.key_name
}