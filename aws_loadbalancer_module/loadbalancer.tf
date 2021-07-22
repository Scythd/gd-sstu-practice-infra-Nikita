resource "aws_elb" "load_balancer" {
  name            = "app-terraform-elb"
  security_groups = ["${aws_security_group.sglb2.id}"]
  subnets         = [var.public_subnet]


  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 180
  }

  instances                   = [aws_instance.app.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "app-java-terraform-elb"
  }
}
