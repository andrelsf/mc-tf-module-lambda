resource "aws_cloudwatch_log_group" "cw_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.cw_log_group_retention_in_days
}