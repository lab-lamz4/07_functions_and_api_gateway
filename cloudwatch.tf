module "cloudwatch_api" {
  source = "../../modules/cloudwatch"

  enable_cw_metric_alarm = false

  # CloudWatch LOG group
  enable_cw_log_group            = true
  cw_log_group_name              = "api_logs"
  cw_log_group_retention_in_days = 5


  # CloudWatch LOG metric filter
  enable_cw_log_metric_filter  = false


  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })
}
