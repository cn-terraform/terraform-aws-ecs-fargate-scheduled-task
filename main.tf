#------------------------------------------------------------------------------
# CLOUDWATCH EVENT ROLE
#------------------------------------------------------------------------------
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

data "aws_iam_policy_document" "scheduled_task_cw_event_role_cloudwatch_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = ["*"]
  }
  statement {
    actions   = ["iam:PassRole"]
    resources = var.ecs_task_role_arn == null ? [var.ecs_execution_task_role_arn] : [var.ecs_execution_task_role_arn, var.ecs_task_role_arn]
  }
}

resource "aws_iam_role" "scheduled_task_cw_event_role" {
  name               = "${var.name_prefix}-st-cw-role"
  assume_role_policy = data.aws_iam_policy_document.scheduled_task_cw_event_role_assume_role_policy.json
}

resource "aws_iam_role_policy" "scheduled_task_cw_event_role_cloudwatch_policy" {
  name   = "${var.name_prefix}-st-cw-policy"
  role   = aws_iam_role.scheduled_task_cw_event_role.id
  policy = data.aws_iam_policy_document.scheduled_task_cw_event_role_cloudwatch_policy.json
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = var.event_rule_name
  schedule_expression = var.event_rule_schedule_expression
  event_bus_name      = var.event_rule_event_bus_name
  event_pattern       = var.event_rule_event_pattern
  description         = var.event_rule_description
  role_arn            = var.event_rule_role_arn
  is_enabled          = var.event_rule_is_enabled
  tags = {
    Name = "${var.name_prefix}-cw-event-rule"
  }
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT TARGET
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  rule           = aws_cloudwatch_event_rule.event_rule.name
  event_bus_name = aws_cloudwatch_event_rule.event_rule.event_bus_name
  target_id      = var.event_target_target_id
  arn            = var.ecs_cluster_arn
  input          = var.event_target_input
  input_path     = var.event_target_input_path
  role_arn       = aws_iam_role.scheduled_task_cw_event_role.arn

  ecs_target {
    group               = var.event_target_ecs_target_group
    launch_type         = "FARGATE"
    platform_version    = var.event_target_ecs_target_platform_version
    task_count          = var.event_target_ecs_target_task_count
    task_definition_arn = var.event_target_ecs_target_task_definition_arn
    propagate_tags      = var.event_target_ecs_target_propagate_tags

    network_configuration {
      subnets          = var.event_target_ecs_target_subnets
      security_groups  = var.event_target_ecs_target_security_groups
      assign_public_ip = var.event_target_ecs_target_assign_public_ip
    }
  }
}
