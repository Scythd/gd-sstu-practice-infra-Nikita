resource "aws_instance" "app" {
  ami                         = var.image_id
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${var.instance_sg}", "${aws_security_group.sglb1.id}"]
  iam_instance_profile        = "EcrPullPushRole"
  key_name                    = var.key_name

  instance_initiated_shutdown_behavior = "terminate"

  subnet_id = var.subnet

  user_data = filebase64("${path.module}/DPullRun.sh")

  tags = {
    Name = "App"
  }

}