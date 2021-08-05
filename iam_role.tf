module "iam_role_lambda" {
  source      = "../../modules/iam_role"
  name        = "epam-leodorov-lambda"
  environment = "learning"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "iam_role_for_lambda"
  iam_role_description = "Role to allow lambda to do something"
  # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
  iam_role_assume_role_policy = file("additional_files/assume_role_policy_lambda.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "iam_policy_for_lambda"
  iam_role_policy        = file("additional_files/policy_lambda.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment      = false

  # Using IAM instance profile
  enable_iam_instance_profile = false

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })
}

module "iam_role_api" {
  source      = "../../modules/iam_role"
  name        = "epam-leodorov-api"
  environment = "learning"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "iam_role_for_api"
  iam_role_description = "Role to allow api to logging into cloudwatch"
  # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
  iam_role_assume_role_policy = file("additional_files/assume_role_policy_api.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "iam_policy_for_api"
  iam_role_policy        = file("additional_files/policy_api.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment      = false

  # Using IAM instance profile
  enable_iam_instance_profile = false

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "lambda"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })
}
