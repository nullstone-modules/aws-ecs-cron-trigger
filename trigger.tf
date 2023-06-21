resource "aws_cloudwatch_event_rule" "this" {
  name                = local.resource_name
  schedule_expression = var.schedule
  tags                = local.tags
}

resource "aws_cloudwatch_event_target" "this" {
  rule     = aws_cloudwatch_event_rule.this.name
  arn      = local.cluster_arn
  role_arn = aws_iam_role.this.arn

  ecs_target {
    tags                   = local.tags
    task_count             = 1
    task_definition_arn    = "arn:aws:ecs:${local.region}:${local.account_id}:task-definition/${local.task_definition_name}:latest"
    launch_type            = local.launch_type
    enable_execute_command = true

    network_configuration {
      subnets          = local.private_subnet_ids
      assign_public_ip = false
      security_groups  = [local.security_group_id]
    }
  }

  input = jsonencode({
    containerOverrides = []
  })
}
