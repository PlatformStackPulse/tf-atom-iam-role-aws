mock_provider "aws" {}

# Shared sample inputs for all runs: tf-label context labels plus this
# atom's own required variable (assume_role_policy).
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }

  assert {
    condition     = output.role_name != null
    error_message = "role_name should not be null when the role is created"
  }

  # role_name is derived from the tf-label id and is known at plan time,
  # so we can assert its exact value. (role_arn is unknown until apply.)
  assert {
    condition     = output.role_name == "eg-test-thing"
    error_message = "role_name should equal the tf-label id 'eg-test-thing'"
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report disabled when enabled = false"
  }

  assert {
    condition     = output.role_arn == null
    error_message = "role_arn must be null when the module is disabled"
  }

  assert {
    condition     = output.role_name == null
    error_message = "role_name must be null when the module is disabled"
  }
}
