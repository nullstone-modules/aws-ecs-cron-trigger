data "aws_iam_policy_document" "this_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${local.resource_name}-exec"
  assume_role_policy = data.aws_iam_policy_document.this_assume.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = [replace(local.task_definition_arn, "/:\\d+$/", ":*")]
  }
}

resource "aws_iam_role_policy" "this" {
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.this.json
}