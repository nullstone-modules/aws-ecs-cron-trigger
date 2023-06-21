output "events" {
  value = [
    {
      rule_name = aws_cloudwatch_event_rule.this.name
      role_arn  = aws_iam_role.events.arn
      input     = jsonencode({
        containerOverrides = []
      })
    }
  ]
}
