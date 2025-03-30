resource "aws_codebuild_project" "project" {
  name         = "${var.project_name}-${var.env}-codebuild-project"
  description  = "${var.project_name}-${var.env}-codebuild-project"
  service_role = aws_iam_role.codebuild_service_role.arn
  build_timeout = "5"
 
  artifacts {
    type = "CODEPIPELINE"
  }
 
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
 
    environment_variable {
      name  = "ECR_REPOSITORY"
      value = aws_ecr_repository.main.repository_url
    }
 
  }
 
  source {
    type            = "CODEPIPELINE"
    buildspec       = "terraform/envs/${var.env}/buildspec.yml"
  }
}