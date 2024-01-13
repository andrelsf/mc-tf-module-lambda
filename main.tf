#
# Terraform AWS Module Lambda function
#
resource "aws_lambda_function" "this" {
  description                    = var.lambda_description
  function_name                  = var.lambda_function_name
  runtime                        = var.lambda_runtime
  handler                        = var.lambda_handler
  architectures                  = var.lambda_architectures
  package_type                   = var.lambda_package_type
  filename                       = var.lambda_filename
  source_code_hash               = filebase64sha256(var.lambda_filename)
  publish                        = var.lambda_publish
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions
  role                           = var.lambda_iam_role
  environment {
    variables = var.lambda_variables
  }
  ephemeral_storage {
    size = var.lambda_ephemeral_storage
  }
}

resource "aws_lambda_alias" "this" {
  description      = format("Lambda alias '%s'", var.lambda_alias)
  name             = var.lambda_alias
  function_name    = aws_lambda_function.this.arn
  function_version = aws_lambda_function.this.version
}