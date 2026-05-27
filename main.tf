# -----------------------------------------------------
# Atom: IAM Role
# Creates a single IAM role with an assume role policy.
# -----------------------------------------------------
resource "aws_iam_role" "this" {
  count = module.this.enabled ? 1 : 0

  name                  = module.this.id
  description           = coalesce(var.description, "IAM role: ${module.this.id}")
  assume_role_policy    = var.assume_role_policy
  path                  = var.path
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies

  tags = local.tags
}
