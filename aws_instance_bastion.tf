resource "aws_instance" "bastion" {
  /* ami                         = "ami-09e67e426f25ce0d7"*/
  ami                         = "ami-018042f56926ea213"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion-key.key_name
  vpc_security_group_ids      = ["${aws_security_group.public.id}", module.loadbalancer.bastion_sg_id]
  iam_instance_profile        = "Bastion"

  subnet_id         = aws_subnet.public.id
  source_dest_check = false

  user_data = filebase64("${path.module}/BastionConfigure.sh")

  tags = {
    Name = "Bastion"
  }
}
