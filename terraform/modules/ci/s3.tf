resource "aws_s3_bucket" "pipeline" {
  bucket = "s3-pipeline-${var.project_name}-${var.env}"
}