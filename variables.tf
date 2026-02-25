######
# Misc
######
variable "name_prefix" {
  description = "Name prefix for resources on AWS."
  type        = string
}

variable "additional_tags" {
  description = "(Optional) Additional tags to add to resources. These will be merged with the default tags added by the module. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
  type        = map(string)
}

#######################
# CloudWatch Event Rule
#######################
variable "event_rule_description" {
  description = "(Optional) The description of the rule."
  default     = null
  type        = string
}

variable "event_rule_event_bus_name" {
  description = "(Optional) The name or ARN of the event bus to associate with this rule. If you omit this, the default event bus is used."
  default     = null
  type        = string
}

variable "event_rule_event_pattern" {
  description = "(Optional) The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. Note: The event pattern size is 2048 by default but it is adjustable up to 4096 characters by submitting a service quota increase request."
  default     = null
  type        = string
}

variable "event_rule_force_destroy" {
  description = "(Optional) Used to delete managed rules created by AWS. Defaults to false."
  default     = false
  type        = bool
}

variable "event_rule_name" {
  description = "The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  type        = string
}

variable "event_rule_schedule_expression" {
  description = "(Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus."
  default     = null
  type        = string
}

variable "event_rule_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation. If not set a role will be created with the necessary permissions to invoke the target when the rule is triggered."
  default     = null
  type        = string
}

variable "event_rule_state" {
  description = "(Optional) State of the rule. Valid values are DISABLED, ENABLED, and ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS. When state is ENABLED, the rule is enabled for all events except those delivered by CloudTrail. To also enable the rule for events delivered by CloudTrail, set state to ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS. Defaults to ENABLED."
  default     = "ENABLED"
  type        = string

  validation {
    condition     = contains(["DISABLED", "ENABLED", "ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS"], var.event_rule_state)
    error_message = "var.event_rule_state must be one of DISABLED, ENABLED, or ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS"
  }
}

#########################
# CloudWatch Event Target
#########################
variable "event_target_ecs_cluster_arn" {
  description = "The ECS Cluster where the scheduled task will run."
  type        = string
}

variable "event_target_force_destroy" {
  description = "(Optional) Used to delete managed rules created by AWS. Defaults to false."
  default     = false
  type        = bool
}

variable "event_target_input" {
  description = "(Optional) Valid JSON text passed to the target. Conflicts with event_target_input_path and event_target_input_transformer."
  default     = null
  type        = string
}

variable "event_target_input_path" {
  description = "(Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. Conflicts with event_target_input and event_target_input_transformer."
  default     = null
  type        = string
}

variable "event_target_input_transformer" {
  description = "(Optional) Parameters used when you are providing a custom event_target_input to a target based on certain event data. Conflicts with input and event_target_input_path."
  default     = null
  type = object({
    input_template = string
    input_paths    = optional(map(string))
  })
}

variable "event_target_target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
  type        = string
}

variable "event_target_retry_policy_maximum_event_age_in_seconds" {
  description = "(Optional) The age in seconds to continue to make retry attempts."
  default     = null
  type        = number
}

variable "event_target_retry_policy_maximum_retry_attempts" {
  description = "(Optional) maximum number of retry attempts to make before the request fails."
  default     = null
  type        = number
}

variable "event_target_ecs_target_enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the task."
  default     = false
  type        = bool
}

variable "event_target_ecs_target_enable_execute_command" {
  description = "(Optional) Whether or not to enable the execute command functionality for the containers in this task. If true, this enables execute command functionality on all containers in the task."
  default     = false
  type        = bool
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

variable "event_target_ecs_target_propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags are not propagated. Tags can only be propagated to the task during task creation. The only valid value is: TASK_DEFINITION."
  default     = ""
  type        = string

  validation {
    condition     = var.event_target_ecs_target_propagate_tags == "" || var.event_target_ecs_target_propagate_tags == "TASK_DEFINITION"
    error_message = "The only valid value for event_target_ecs_target_propagate_tags is TASK_DEFINITION or it can be left empty."
  }
}

variable "event_target_ecs_target_task_count" {
  description = "(Optional) The number of tasks to create based on the TaskDefinition. Defaults to 1."
  default     = 1
  type        = number
}

variable "event_target_ecs_target_task_definition_arn" {
  description = "(Required) The ARN of the task definition to use if the event target is an Amazon ECS cluster."
  type        = string
}

variable "event_target_ecs_target_assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI. Valid values are true or false. Defaults to false."
  default     = false
  type        = bool
}

variable "event_target_ecs_target_subnets" {
  description = "(Required) The subnets associated with the task or service."
  type        = list(string)
}

variable "event_target_ecs_target_security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  default     = null
  type        = list(string)
}

variable "event_target_ecs_target_additional_tags" {
  description = "(Optional) Additional tags to add to the ECS target. These will be merged with the default tags added by the module and the additional_tags variable. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
  type        = map(string)
}

#######################
# CloudWatch Event Role
#######################
variable "ecs_execution_task_role_arn" {
  description = "(Optional) The task definition execution role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
  default     = null
  type        = string
}

variable "ecs_task_role_arn" {
  description = "(Optional) The task definition role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
  default     = null
  type        = string
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}
