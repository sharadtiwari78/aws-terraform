#create codebuild project for preprod
resource "aws_codebuild_project" "codebuild_project" {
  name          = "${var.environment}-${var.codebuild_project_name}"
  description   = "${var.environment}-${var.codebuild_project_name}"
  build_timeout = var.codebuild_timeout
  service_role  = aws_iam_role.codebuild_iam_role.arn

  artifacts {
    type = var.artifacts_type

  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = var.type
    image_pull_credentials_type = var.image_pull_credentials_type

    environment_variable {
      name  = var.environment_variable_name
      value = var.value
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "${var.environment}-${var.cloudwatch_group_name}"
      stream_name = "${var.environment}-${var.cloudwatch_stream_name}"
    }
  }
  source {
    type      = var.source_type
    buildspec = var.buildspec
  }
}
