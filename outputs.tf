# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
# ---------------------------------------------------------------------------------------------------------------------
output "aws_cloudwatch_event_rule_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the CloudWatch Event Rule."
  value       = aws_cloudwatch_event_rule.event_rule.arn
}

