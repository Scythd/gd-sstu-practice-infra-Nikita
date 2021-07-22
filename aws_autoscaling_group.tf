resource "aws_launch_template" "docker_lt" {
  name          = "docker_lt"
  image_id      = "ami-083f9da9062568d5a"
  instance_type = "t2.micro"

  instance_initiated_shutdown_behavior = "terminate"

  user_data = filebase64("${path.module}/DPullRun.sh")

  iam_instance_profile {
    name = "EcrPullPushRole"
  }

  key_name = aws_key_pair.bastion-key.key_name

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private.id
    security_groups             = [module.loadbalancer.app_sg_id, aws_security_group.private.id, aws_security_group.db_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "App"
    }
  }

}

resource "aws_autoscaling_group" "appscaling" {
  availability_zones = ["us-east-1a"]
  max_size           = 5
  min_size           = 1
  desired_capacity   = 1

  load_balancers = [module.loadbalancer.id]


  launch_template {
    id      = aws_launch_template.docker_lt.id
    version = "$Latest"
  }

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  timeouts {
    delete = "15m"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scaling_policy" {
  name = "scaling_policy"

  autoscaling_group_name = aws_autoscaling_group.appscaling.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }


}