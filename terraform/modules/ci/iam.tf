data "aws_iam_policy_document" "codebuild_service_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "codepipeline_service_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

# CodeBuild 基本権限ポリシー
resource "aws_iam_policy" "codebuild_policy" {
  name        = "policy-${var.project_name}-${var.env}-codebuild"
  description = "Policy for CodeBuild"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "codestar-connections:UseConnection",
        "Resource" : "*"
      },
    ]
  })
}

# CodePipeline 基本権限ポリシー
resource "aws_iam_policy" "codepipeline_policy" {
  name        = "policy-${var.project_name}-${var.env}-codepipeline"
  description = "Policy for CodePipeline"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObject"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:UploadArchive",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:CancelUploadArchive"
        ]
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "codestar-connections:UseConnection"
        ],
        "Resource" : "*"
      },
    ]
  })
}

resource "aws_iam_role" "codebuild_service_role" {
  name               = "role-${var.project_name}-${var.env}-codebuild-service-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_service_role.json
}

resource "aws_iam_role" "codepipeline_service_role" {
  name               = "role-${var.project_name}-${var.env}-codepipeline-service-role"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_service_role.json
}

resource "aws_iam_role_policy_attachment" "ssm_parameter_attachment" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = var.ssm_parameter_access_policy_arn
}
resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}
resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}

