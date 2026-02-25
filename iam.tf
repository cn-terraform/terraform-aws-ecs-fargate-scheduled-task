#######################
# CloudWatch Event Role
#######################
data "aws_iam_policy_document" "scheduled_task_cw_event_role_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "scheduled_task_cw_event_role" {
  count                = var.event_rule_role_arn == null ? 1 : 0
  name                 = format("%s-st-cw-role", var.name_prefix)
  assume_role_policy   = data.aws_iam_policy_document.scheduled_task_cw_event_role_assume_role_policy.json
  permissions_boundary = var.permissions_boundary
}

data "aws_iam_policy_document" "scheduled_task_cw_event_role_run_ecs_tasks_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = ["*"]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values   = [var.event_target_ecs_cluster_arn]
    }
  }
}

data "aws_iam_policy_document" "scheduled_task_cw_event_role_pass_role_policy" {
  count = var.ecs_execution_task_role_arn == null && var.ecs_task_role_arn == null ? 0 : 1

  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      var.ecs_execution_task_role_arn != null ? var.ecs_execution_task_role_arn : null,
      var.ecs_task_role_arn != null ? var.ecs_task_role_arn : null
    ]
  }
}

data "aws_iam_policy_document" "scheduled_task_cw_event_role_cloudwatch_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.scheduled_task_cw_event_role_run_ecs_tasks_policy.json,
    var.ecs_execution_task_role_arn == null && var.ecs_task_role_arn == null ? null : data.aws_iam_policy_document.scheduled_task_cw_event_role_pass_role_policy[0].json
  ]
}

resource "aws_iam_role_policy" "scheduled_task_cw_event_role_cloudwatch_policy" {
  count  = var.event_rule_role_arn == null ? 1 : 0
  name   = format("%s-st-cw-policy", var.name_prefix)
  role   = aws_iam_role.scheduled_task_cw_event_role[0].id
  policy = data.aws_iam_policy_document.scheduled_task_cw_event_role_cloudwatch_policy.json
}
