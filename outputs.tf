#------------------------------------------------------------------------------
# CLOUDWATCH EVENT ROLE
#------------------------------------------------------------------------------
output "scheduled_task_cw_event_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.scheduled_task_cw_event_role.arn
}

output "scheduled_task_cw_event_role_create_date" {
  description = "The creation date of the IAM role."
  value       = aws_iam_role.scheduled_task_cw_event_role.create_date
}

output "scheduled_task_cw_event_role_description" {
  description = "The description of the role."
  value       = aws_iam_role.scheduled_task_cw_event_role.description
}

output "scheduled_task_cw_event_role_id" {
  description = "The name of the role."
  value       = aws_iam_role.scheduled_task_cw_event_role.id
}

output "scheduled_task_cw_event_role_name" {
  description = "The name of the role."
  value       = aws_iam_role.scheduled_task_cw_event_role.name
}

output "scheduled_task_cw_event_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = aws_iam_role.scheduled_task_cw_event_role.unique_id
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name."
  value       = aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy.id
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_name" {
  description = "The name of the policy."
  value       = aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy.name
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_policy" {
  description = "The policy document attached to the role."
  value       = aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy.policy
}

output "aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_role" {
  description = "The name of the role associated with the policy."
  value       = aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy.role
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
