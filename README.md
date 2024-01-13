# Terraform AWS Module Lambda function

Multicode Terraform AWS module Lambda function

## Using the module

1. Simple example of using the module

```hcl
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
```
2. Add IAM Role, trust policy and Cloudwatch policy for Cloudwatch

Example:
```hcl
resource "aws_iam_role" "lambda_role" {
  name               = "LambdaFunctionDynamoDBRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy_document.json
  managed_policy_arns = [
    resource.aws_iam_policy.lambda_policy.arn
  ]
}

resource "aws_iam_policy" "lambda_policy" {
  description = "Permission for lambda Challenge Proof to access dynamodb table"
  name        = "LambdaFunctionDynamoDBPolicy"
  policy      = data.aws_iam_policy_document.lambda_policy_document.json
}

data "aws_iam_policy_document" "lambda_trust_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    sid    = "LambdaFunctionCloudwatchBPolicyDocument"
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
```

3. Add the AWS provider

Example:

```hcl
provider "aws" {
  region                   = "us-east-1"
  profile                  = "default"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}
```

## Referencies

- [Terraform AWS Lambda function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
- [Terraform AWS Cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)