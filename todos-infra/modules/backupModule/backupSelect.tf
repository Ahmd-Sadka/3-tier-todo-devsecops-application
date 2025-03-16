resource "aws_backup_selection" "resource_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "resources-selection"
  plan_id      = aws_backup_plan.pipeline_plan.id

  resources = [var.target_backup_arn]
}