#######################
# Cloudwatch Event Rule
#######################
resource "aws_cloudwatch_event_rule" "event_rule" {
  description         = var.event_rule_description
  event_bus_name      = var.event_rule_event_bus_name
  event_pattern       = var.event_rule_event_pattern
  force_destroy       = var.event_rule_force_destroy
  name                = var.event_rule_name
  role_arn            = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].arn : var.event_rule_role_arn
  schedule_expression = var.event_rule_schedule_expression
  state               = var.event_rule_state

  tags = merge(
    var.additional_tags,
    {
      Name = format("%s-cw-event-rule", var.name_prefix)
    }
  )
}

#########################
# CloudWatch Event Target
#########################
resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  arn            = var.event_target_ecs_cluster_arn
  rule           = aws_cloudwatch_event_rule.event_rule.name
  event_bus_name = aws_cloudwatch_event_rule.event_rule.event_bus_name
  force_destroy  = var.event_target_force_destroy
  input          = var.event_target_input
  input_path     = var.event_target_input_path
  role_arn       = aws_cloudwatch_event_rule.event_rule.role_arn
  target_id      = var.event_target_target_id

  dynamic "input_transformer" {
    for_each = var.event_target_input_transformer == null ? [] : [var.event_target_input_transformer]
    content {
      input_template = input_transformer.value.input_template
      input_paths    = input_transformer.value.input_paths
    }
  }

  retry_policy {
    maximum_event_age_in_seconds = var.event_target_retry_policy_maximum_event_age_in_seconds
    maximum_retry_attempts       = var.event_target_retry_policy_maximum_retry_attempts
  }

  ecs_target {
    enable_ecs_managed_tags = var.event_target_ecs_target_enable_ecs_managed_tags
    enable_execute_command  = var.event_target_ecs_target_enable_execute_command
    group                   = var.event_target_ecs_target_group
    launch_type             = "FARGATE"
    platform_version        = var.event_target_ecs_target_platform_version
    propagate_tags          = var.event_target_ecs_target_propagate_tags
    task_count              = var.event_target_ecs_target_task_count
    task_definition_arn     = var.event_target_ecs_target_task_definition_arn

    network_configuration {
      assign_public_ip = var.event_target_ecs_target_assign_public_ip
      subnets          = var.event_target_ecs_target_subnets
      security_groups  = var.event_target_ecs_target_security_groups
    }

    tags = merge(
      var.additional_tags,
      var.event_target_ecs_target_additional_tags,
      {
        Name = format("%s-cw-event-target", var.name_prefix)
      }
    )
  }
}
