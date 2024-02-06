resource "aws_iam_policy" "ec2_policy" {
  name        = var.iam_policy_name
  path        = var.iam_policy_path
  description = var.iam_policy_description
  policy      = var.iam_policy_definitions
  tags        = var.tags
}

resource "aws_iam_role" "ec2_role" {
  name                  = var.iam_role_name
  assume_role_policy    = var.iam_role_definitions
  force_detach_policies = var.force_detach_policies
  path                  = var.iam_role_path
  description           = var.iam_role_description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  tags                  = var.tags
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.ec2_profile_name
  role = aws_iam_role.ec2_role.name
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each   = toset(var.aws_managed_policy)
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}