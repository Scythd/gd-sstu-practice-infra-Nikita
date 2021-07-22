resource "aws_cloudwatch_log_group" "ASG_Metrics_Group" {
  name              = "ASG_Metrics_Group"
  retention_in_days = 1
  tags = {
    Environment = "production"
  }
}
resource "aws_cloudwatch_log_stream" "ASG_Log_Stream" {
  name           = "ASGLogStream"
  log_group_name = aws_cloudwatch_log_group.ASG_Metrics_Group.name
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "AutoScalingGroupName",
            "${aws_autoscaling_group.appscaling.id}"
          ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "CPU"
      }
    },
    {
      "type": "metric",
      "x": 13,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Memory"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 7,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Disk"
      }
    },
    {
      "type": "metric",
      "x": 13,
      "y": 7,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Network usage"
      }
    }
  ]
}
EOF
}