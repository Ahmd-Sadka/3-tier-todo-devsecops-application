resource "aws_backup_plan" "pipeline_plan" {
    name = "backup-plan"
    
    rule {
      rule_name         = "backup-rule"
      target_vault_name = "Default"
      schedule          = "cron(0 12 * * ? *)" # daily at 12:00
      completion_window = 120
      lifecycle {
        delete_after = 14
      }
    }
  
}