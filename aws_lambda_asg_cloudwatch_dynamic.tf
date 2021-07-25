
#resource "aws_lambda_function" "test_lambda" {
#  filename      = "ec2DashboardUpdater.zip"
#  function_name = "ec2DashboardUpdaterSSTUPRAC"
#  role          = "ec2DashboardUpdaterRole"
#  handler       = "ec2DashboardUpdater.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  # source_code_hash = filebase64sha256("lambda_function_payload.zip")

#  timeout = 300

#  environment {
#    variables = {
#      AWS_DASHBOARDS = "[{\"dashboardName\":${aws_cloudwatch_dashboard.main.dashboard_name},\"ec2DescribeInstanceParams\":{\"Filters\":[{\"Name\":\"instance-state-name\",\"Values\":[\"running\"]},{\"Name\":\"tag:Name\",\"Values\":[\"App\"]}]}}]"
#    
#    }
#  }
#}