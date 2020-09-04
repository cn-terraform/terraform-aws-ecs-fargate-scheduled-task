#------------------------------------------------------------------------------
# CLOUDWATCH EVENT ROLE
#------------------------------------------------------------------------------
resource "aws_iam_role" "scheduled_task_cw_event_role" {
  name               = "${var.name_preffix}-st-cw-role"
  assume_role_policy = file("${path.module}/files/iam/scheduled_task_cw_event_role_assume_role_policy.json")
}

data "template_file" "scheduled_task_cw_event_role_cloudwatch_policy" {
  template = file("${path.module}/files/iam/scheduled_task_cw_event_role_cloudwatch_policy.json")
  vars = {
    TASK_EXECUTION_ROLE_ARN = var.ecs_execution_task_role_arn
  }
}

resource "aws_iam_role_policy" "scheduled_task_cw_event_role_cloudwatch_policy" {
  name   = "${var.name_preffix}-st-cw-policy"
  role   = aws_iam_role.scheduled_task_cw_event_role.id
  policy = data.template_file.scheduled_task_cw_event_role_cloudwatch_policy.rendered
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = var.event_rule_name
  description         = var.event_rule_description
  schedule_expression = var.event_rule_schedule_expression
  event_pattern       = var.event_rule_event_pattern
  role_arn            = var.event_rule_role_arn
  is_enabled          = var.event_rule_is_enabled
  tags = {
    Name = "${var.name_preffix}-cw-event-rule"
  }
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT TARGET
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  rule       = aws_cloudwatch_event_rule.event_rule.name
  target_id  = var.event_target_target_id
  arn        = var.ecs_cluster_arn
  input      = var.event_target_input
  input_path = var.event_target_input_path
  role_arn   = aws_iam_role.scheduled_task_cw_event_role.arn
  ecs_target {
    task_definition_arn = var.event_target_ecs_target_task_definition_arn
    task_count          = var.event_target_ecs_target_task_count
    platform_version    = var.event_target_ecs_target_platform_version
    launch_type         = "FARGATE"
    group               = var.event_target_ecs_target_group
    network_configuration {
      subnets          = var.event_target_ecs_target_subnets
      security_groups  = var.event_target_ecs_target_security_groups
      assign_public_ip = var.event_target_ecs_target_assign_public_ip
    }
  }
}
