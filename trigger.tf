resource "aws_cloudwatch_event_rule" "this" {
  name                = local.resource_name
  schedule_expression = var.schedule
  tags                = local.tags
}
