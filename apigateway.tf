resource "aws_apigatewayv2_api" "app_api" {
  name          = "learning-api"
  description   = "Api for learning"
  protocol_type = "HTTP"
  tags          = {
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  }
}

resource "aws_api_gateway_account" "app_api_acc" {
  cloudwatch_role_arn = module.iam_role_api.iam_role_arn

  depends_on = [
		module.iam_role_api
  ]
}

resource "aws_apigatewayv2_route" "api_lambda_route" {
  api_id    = aws_apigatewayv2_api.app_api.id
  route_key = "ANY /v1/test"

  target = "integrations/${aws_apigatewayv2_integration.api_lambda.id}"

  depends_on = [
		aws_apigatewayv2_api.app_api,
		aws_apigatewayv2_integration.api_lambda
  ]
}

resource "aws_apigatewayv2_integration" "api_lambda" {
  api_id           = aws_apigatewayv2_api.app_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  # content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda answer"
  integration_method        = "POST"
  integration_uri           = module.lambda.lambda_alias_invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"

  depends_on = [
		aws_apigatewayv2_api.app_api,
		module.lambda
  ]
}

resource "aws_apigatewayv2_stage" "app_api_stage" {
  api_id = aws_apigatewayv2_api.app_api.id
  name   = "test-stage"

	auto_deploy = true
  access_log_settings {
      destination_arn = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:api_logs"
			format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }

	route_settings {
    route_key                = aws_apigatewayv2_route.api_lambda_route.route_key
    logging_level            = "INFO"
    detailed_metrics_enabled = true
		throttling_burst_limit = 5
		throttling_rate_limit = 2
  }
  
	tags          = {
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  }

  depends_on = [
		aws_apigatewayv2_route.api_lambda_route,
		module.cloudwatch_api
	]
}