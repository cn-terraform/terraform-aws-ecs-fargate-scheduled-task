#------------------------------------------------------------------------------
# CLOUDWATCH EVENT ROLE
#------------------------------------------------------------------------------
output "scheduled_task_cw_event_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].arn : null
}

output "scheduled_task_cw_event_role_create_date" {
  description = "The creation date of the IAM role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].create_date : null
}

output "scheduled_task_cw_event_role_description" {
  description = "The description of the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].description : null
}

output "scheduled_task_cw_event_role_id" {
  description = "The name of the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].id : null
}

output "scheduled_task_cw_event_role_name" {
  description = "The name of the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].name : null
}

output "scheduled_task_cw_event_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role.scheduled_task_cw_event_role[0].unique_id : null
}
output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name."
  value       = var.event_rule_role_arn == null ? aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy[0].id : null
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_name" {
  description = "The name of the policy."
  value       = var.event_rule_role_arn == null ? aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy[0].name : null
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_policy" {
  description = "The policy document attached to the role."
  value       = var.event_rule_role_arn == null ? aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy[0].policy : null
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_role" {
  description = "The name of the role associated with the policy."
  value       = var.event_rule_role_arn == null ? aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy[0].role : null
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
output "aws_cloudwatch_event_rule_event_rule_id" {
  description = "The name of the rule."
  value       = aws_cloudwatch_event_rule.event_rule.id
}

output "aws_cloudwatch_event_rule_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the CloudWatch Event Rule."
  value       = aws_cloudwatch_event_rule.event_rule.arn
}
