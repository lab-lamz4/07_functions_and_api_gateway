module "lambda" {
  source      = "../../modules/lambda"
  name        = "mylambdaonpython"
  environment = "learning"

  # AWS Lambda
  enable_lambda_function  = true
  lambda_function_name    = "mylambdaonpython"
  lambda_function_handler = "lambda_function.lambda_handler"
  lambda_function_role    = module.iam_role_lambda.iam_role_arn
  lambda_function_runtime = "python3.7"
  lambda_function_publish = true


  lambda_function_filename         = "./additional_files/lambda_function.zip"
  lambda_function_source_code_hash = filebase64sha256("./additional_files/lambda_function.zip")

  lambda_function_environment = {
    key = "value",
    Env = "dev"
  }

  # AWS Lambda Alias
  enable_lambda_alias           = true
  lambda_alias_name             = "api_test_call"
  lambda_alias_function_version = "$LATEST"

  # Add lambda event source mapping
  enable_lambda_event_source_mapping           = false

  # Lambda fun event invoke config
  enable_lambda_function_event_invoke_config = false

  # Lambda provisioned concurrency config
  enable_lambda_provisioned_concurrency_config = false

  # Lambda permission
  enable_lambda_permission        = true
  lambda_permission_statement_id  = "AllowExecutionFromAPIGateway"
  lambda_permission_action        = "lambda:InvokeFunction"
  lambda_permission_principal     = "apigateway.amazonaws.com"
  lambda_permission_source_arn    = "${aws_apigatewayv2_api.app_api.execution_arn}/*/*"
  

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })
}
