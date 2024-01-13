output "lambda_function_arn" {
  description = "(Output) Amazon Resource Name (ARN) of the function's"
  value = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  description = "(Output) Unique name for your Lambda Function"
  value = aws_lambda_function.this.function_name
}