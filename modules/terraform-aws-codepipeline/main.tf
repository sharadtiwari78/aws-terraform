#create codepipeline
resource "aws_codepipeline" "Codepipeline" {
  name     = "${var.environment}-${var.codepipeline_name}"
  role_arn = aws_iam_role.Codepipeline_iam_role.arn

  artifact_store {
    location = var.artifact_store["location"]
    type     = var.artifact_store["type"]
  }
  dynamic "stage" {
    for_each = [for s in var.stages : {
      name   = s.name
      action = s.action
    } if(lookup(s, "enabled", true))]

    content {
      name = stage.value.name
      dynamic "action" {
        for_each = stage.value.action
        content {
          name             = action.value["name"]
          owner            = action.value["owner"]
          version          = action.value["version"]
          category         = action.value["category"]
          provider         = action.value["provider"]
          input_artifacts  = lookup(action.value, "input_artifacts", [])
          output_artifacts = lookup(action.value, "output_artifacts", [])
          run_order        = lookup(action.value, "run_order", null)
          configuration    = lookup(action.value, "configuration", {})
          role_arn         = lookup(action.value, "role_arn", null)
        }
      }
    }
  }
}


