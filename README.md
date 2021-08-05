# 07_functions_and_api_gateway

The task to deploy API Gateway with staging + routing to lambda + logs into CloudWatch, and as it could be guessed - deploy lambda function that serves to requests from API + alias to get ability split traffic to different lambda versions + logs into CloudWatch

unfortunately, modules for creating API GW using aws_apigatewayv2* resources haven't existed yet, so I use it without modules.

## Used resources

terraform modules from https://github.com/SebastianUA/terraform.git

Great thanks to Vitaliy Natarov!

## AWS CREDENTIALS

```
aws configure
```

## Terrfaorm

```
terraform init
terrafrom plan
terrafrom apply
terraform destroy
```