data "aws_iam_policy_document" "ssm_parameter_access" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:DescribeParameters"
    ]
    resources = [
      "arn:aws:ssm:${var.region}:*:parameter/*"
    ]
  }
  
  # SecureString を復号するための KMS 権限
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ssm_parameter_policy" {
  name        = "${var.project_name}-${var.env}-ssm-parameter-policy"
  description = "Allow ECS tasks to access SSM parameters"
  policy      = data.aws_iam_policy_document.ssm_parameter_access.json
}
