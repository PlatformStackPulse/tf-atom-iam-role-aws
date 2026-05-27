provider "aws" {
  region = "eu-west-1"
}

module "iam_role" {
  source = "../../"

  namespace   = "acme"
  environment = "prod"
  name        = "lambda-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}
