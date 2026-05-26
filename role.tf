resource "aws_iam_role" "events" {
  name               = "${local.resource_name}-events"
  assume_role_policy = data.aws_iam_policy_document.events_assume.json
}

data "aws_iam_policy_document" "events_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "events" {
  role   = aws_iam_role.events.id
  policy = data.aws_iam_policy_document.events.json
}

data "aws_iam_policy_document" "events" {
  statement {
    actions   = ["ecs:RunTask"]
    resources = ["arn:aws:ecs:${local.region}:${local.account_id}:task-definition/${local.task_definition_name}:*"]
  }

  statement {
    actions   = ["ecs:TagResource"]
    resources = ["arn:aws:ecs:${local.region}:${local.account_id}:task/*"]
  }

  statement {
    actions = ["iam:PassRole"]
    resources = compact([
      local.task_role_arn,
      local.execution_role_arn,
    ])

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}
