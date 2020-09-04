#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
variable "event_rule_name" {
  description = "The rule's name."
}

variable "event_rule_schedule_expression" {
  description = "(Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  default     = null
}

variable "event_rule_event_pattern" {
  description = "(Required, if schedule_expression isn't specified) Event pattern described a JSON object. See full documentation of CloudWatch Events and Event Patterns for details."
  default     = null
}

variable "event_rule_description" {
  description = "(Optional) The description of the rule."
  default     = null
}

variable "event_rule_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  default     = null
}

variable "event_rule_is_enabled" {
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT TARGET
#------------------------------------------------------------------------------
variable "ecs_cluster_arn" {
  description = "The ECS Cluster where the scheduled task will run"
}

variable "event_target_ecs_target_subnets" {
  description = "The subnets associated with the task or service."
  type        = list
}

variable "event_target_ecs_target_task_definition_arn" {
  description = "(Required) The ARN of the task definition to use if the event target is an Amazon ECS cluster."
}

variable "ecs_execution_task_role_arn" {
  description = "(Required) The task definition execution role"
}

variable "event_target_target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
}

variable "event_target_input" {
  description = "(Optional) Valid JSON text passed to the target."
  default     = null
}

variable "event_target_input_path" {
  description = "(Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target."
  default     = null
}

variable "event_target_ecs_target_security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list
  default     = []
}

variable "event_target_ecs_target_assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
  type        = bool
  default     = false
}

variable "event_target_ecs_target_task_count" {
  description = "(Optional) The number of tasks to create based on the TaskDefinition. The default is 1."
  type        = number
  default     = 1
}

variable "event_target_ecs_target_platform_version" {
  description = "(Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0. This is used only if LaunchType is FARGATE. For more information about valid platform versions, see AWS Fargate Platform Versions. Default to LATEST"
  default     = "LATEST"
}

variable "event_target_ecs_target_group" {
  description = "(Optional) Specifies an ECS task group for the task. The maximum length is 255 characters."
  default     = null
}
