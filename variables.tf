variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  launch_type         = var.app_metadata["launch_type"]
  role_name           = var.app_metadata["role_name"]
  security_group_id   = var.app_metadata["security_group_id"]
  task_definition_arn = var.app_metadata["task_definition_arn"]
}

variable "schedule" {
  type        = string
  default     = "cron(0 0 * * ? *)"
  description = <<EOF
A cron or rate expression that determines when to trigger the Lambda function.
Default = every day at midnight UTC - cron(0 0 * * ? *)
Cron: cron(minutes, hours, day-of-month, month, day-of-week, year)
Rate: rate(value unit); unit = minute(s)|hour(s)|day(s)
See https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html.
EOF
}
