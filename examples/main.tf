module "lambda_function" {
  source                         = "git::github.com:andrelsf/mc-tf-module-lambda.git?ref=1.0.0"
  lambda_function_name           = "mc-lambda-test"
  lambda_description             = "Lambda to Test"
  lambda_package_type            = "Zip"
  lambda_runtime                 = "python3.11"
  lambda_filename                = "code/lambda_function.zip"
  lambda_handler                 = "lambda_function.lambda_handler"
  lambda_publish                 = true
  lambda_alias                   = "dev"
  lambda_iam_role                = "arn:aws:iam::112233445566:role/LambdaExampleRole"
  cw_log_group_retention_in_days = 7
}