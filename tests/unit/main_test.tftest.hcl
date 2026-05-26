run "enabled_by_default" {
  command = plan
  variables {
    namespace   = "test"
    environment = "dev"
    name        = "my-role"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }]
    })
  }
  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }
}

run "disabled_creates_nothing" {
  command = plan
  variables {
    enabled     = false
    namespace   = "test"
    environment = "dev"
    name        = "my-role"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }]
    })
  }
  assert {
    condition     = output.enabled == false
    error_message = "Module should be disabled"
  }
}

run "role_name_output" {
  command = plan
  variables {
    namespace   = "test"
    environment = "dev"
    name        = "my-role"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }]
    })
  }
  assert {
    condition     = output.role_name != null
    error_message = "Role name should not be null when enabled"
  }
}
