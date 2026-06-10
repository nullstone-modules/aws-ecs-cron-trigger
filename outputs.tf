output "events" {
  value = [
    {
      rule_name = aws_cloudwatch_event_rule.this.name
      role_arn  = aws_iam_role.events.arn
      // EventBridge applies these container overrides to the RunTask it invokes, so the app
      // can distinguish a cron-triggered run (and which schedule fired it) from a manual run.
      // A manual `nullstone run` issues RunTask without these overrides, so the app treats the
      // absence of NULLSTONE_TRIGGER as a manual run.
      input = jsonencode({
        containerOverrides = [
          {
            name = local.main_container_name
            environment = [
              { name = "NULLSTONE_TRIGGER", value = "cron" },
              { name = "NULLSTONE_TRIGGER_NAME", value = local.trigger_name },
            ]
          }
        ]
      })
    }
  ]
}
