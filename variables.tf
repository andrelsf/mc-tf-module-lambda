variable "environment" {
  description = "(Required) Define environment"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "hom", "prod"], var.environment)
    error_message = "Environment unsupported"
  }
}

#
# Variables Lambda Function
#
variable "lambda_description" {
  description = "Description of what your Lambda Function does."
  type        = string
  nullable    = false
}

variable "lambda_function_name" {
  description = "Unique name for your Lambda Function."
  type        = string
  nullable    = false
}

variable "lambda_runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  nullable    = false
}

variable "lambda_handler" {
  description = "Function entrypoint in your code."
  type        = string
  nullable    = false
}

variable "lambda_architectures" {
  description = "Instruction set architecture for your Lambda function."
  type        = list(string)
  default     = ["x86_64"]
}

variable "lambda_package_type" {
  description = "Lambda deployment package type."
  type        = string
  validation {
    condition     = contains(["Zip", "Image"], var.lambda_package_type)
    error_message = "Package type unsupported"
  }
}

variable "lambda_filename" {
  description = "Path to the function's deployment package within the local filesystem."
  type        = string
  nullable    = false
}

variable "lambda_publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  type        = bool
  default     = false
}

variable "lambda_timeout" {
  description = "Amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  type        = number
  default     = 128
}

variable "lambda_reserved_concurrent_executions" {
  description = "(Optional) Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  type        = number
  default     = -1
}

variable "lambda_ephemeral_storage" {
  description = "The amount of Ephemeral storage(/tmp) to allocate for the Lambda Function in MB."
  type        = number
  default     = 512
}

variable "lambda_event_source_batch_size" {
  description = "Lambda event source batch size"
  type        = number
  default     = 1
}

variable "lambda_variables" {
  description = "(Optional) Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present."
  type        = map(string)
  default     = {}
}

variable "lambda_alias" {
  description = "(Required) Name for the alias you are creating."
  type        = string
  nullable    = false
  validation {
    condition     = can(regex("[a-zA-Z0-9-_]+", var.lambda_alias))
    error_message = format("Invalid lambda alias='%s'", var.lambda_alias)
  }
}

#
# Variable Cloudwatch
#
variable "cw_log_group_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 7
  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.cw_log_group_retention_in_days)
    error_message = format("Invalid number of days. '%s'", var.cw_log_group_retention_in_days)
  }
}

#
# Variable IAM Role
#
variable "lambda_iam_role" {
  description = "(Required) Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources."
  type        = string
  validation {
    condition     = can(regex("arn:aws:(iam)::\\d{12}:(role)/\\w", var.lambda_iam_role))
    error_message = "IAM Rrole ARN invalid format"
  }
}
