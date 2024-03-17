#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS."
  type        = string
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
variable "event_rule_name" {
  description = "The name of the rule."
  type        = string
}

variable "event_rule_schedule_expression" {
  description = "(Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of event_rule_schedule_expression or event_rule_event_pattern is required. Can only be used on the default event bus."
  default     = null
  type        = string
}

variable "event_rule_event_bus_name" {
  description = "(Optional) The event bus to associate with this rule. If you omit this, the default event bus is used."
  default     = null
  type        = string
}

variable "event_rule_event_pattern" {
  description = "(Optional) The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required."
  default     = null
  type        = string
}

variable "event_rule_description" {
  description = "(Optional) The description of the rule."
  default     = null
  type        = string
}

variable "event_rule_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  default     = null
  type        = string
}

variable "event_rule_state" {
  description = "(Optional) State of the rule. Valid values are DISABLED, ENABLED, and ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS. When state is ENABLED, the rule is enabled for all events except those delivered by CloudTrail. To also enable the rule for events delivered by CloudTrail, set state to ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS. Defaults to ENABLED."
  default     = "ENABLED"
  type        = string
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT TARGET
#------------------------------------------------------------------------------
variable "event_target_target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
  type        = string
}

variable "ecs_cluster_arn" {
  description = "The ECS Cluster where the scheduled task will run."
  type        = string
}

variable "event_target_input" {
  description = "(Optional) Valid JSON text passed to the target. Conflicts with event_target_input_path."
  default     = null
  type        = string
}

variable "event_target_input_path" {
  description = " (Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. Conflicts with event_target_input."
  default     = null
  type        = string
}

variable "ecs_execution_task_role_arn" {
  description = "(Required) The task definition execution role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
  type        = string
}

variable "ecs_task_role_arn" {
  description = "(Optional) The task definition role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
  default     = null
  type        = string
}

variable "event_target_ecs_target_group" {
  description = "(Optional) Specifies an ECS task group for the task. The maximum length is 255 characters."
  default     = null
  type        = string
}

variable "event_target_ecs_target_platform_version" {
  description = "(Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0. For more information about valid platform versions, see AWS Fargate Platform Versions. Default to LATEST."
  default     = "LATEST"
  type        = string
}

variable "event_target_ecs_target_task_count" {
  description = "(Optional) The number of tasks to create based on the TaskDefinition. The default is 1."
  default     = 1
  type        = number
}

variable "event_target_ecs_target_task_definition_arn" {
  description = "(Required) The ARN of the task definition to use if the event target is an Amazon ECS cluster."
  type        = string
}

variable "event_target_ecs_target_subnets" {
  description = "The subnets associated with the task or service."
  type        = list(any)
}

variable "event_target_ecs_target_security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  default     = null
  type        = list(any)
}

variable "event_target_ecs_target_assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI. Default false."
  default     = false
  type        = bool

}

variable "event_target_ecs_target_propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags are not propagated. Tags can only be propagated to the task during task creation. Valid values: `TASK_DEFINITION` or leave empty to avoid propagation."
  default     = ""
  type        = string
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}