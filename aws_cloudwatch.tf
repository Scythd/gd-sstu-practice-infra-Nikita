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
        "title": "Average ASG CPU"
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
           [ "AWS/EC2", "NetworkIn", "AutoScalingGroupName", "${aws_autoscaling_group.appscaling.id}" ],
           [ ".", "NetworkOut", ".", "." ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "ASG Network usage"
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
          [ { "expression":"SEARCH('{CWAgent,AutoScalingGroupName,ImageId,InstanceId,InstanceType,device,fstype,path} overlay disk_used_percent', 'Average', 60)", 
	      "id": "e1", 
              "period": 60 } ]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Per instance disk usage percent"
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
          [ { "expression":"SEARCH('{CWAgent,AutoScalingGroupName,ImageId,InstanceId,InstanceType}', 'Average', 60)",
          "id": "e1",
          "period": 60 }]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Per instance memory usage percent"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 14,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [ { "expression":"SEARCH('{CWAgent,AutoScalingGroupName,ImageId,InstanceId,InstanceType,cpu} cpu_usage_user', 'Average', 60)", 
            "id": "e1", 
            "period": 60 }]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Per instance cpu usage percent"
      }
    },
    {
      "type": "metric",
      "x": 13,
      "y": 14,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [ { "expression":"SEARCH('{CWAgent,AutoScalingGroupName,ImageId,InstanceId,InstanceType,name} xvda1', 'Average', 60)", 
            "id": "e1", 
            "period": 60 }]
        ],
        "period": 5,
        "stat": "Average",
        "region": "us-east-1",
        "title": "Per instance disk IO"
      }
    }
  ]
}
EOF
}