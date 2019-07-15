# AWS ECS Fargate Scheduled Task Terraform Module #

This Terraform module deploys an AWS ECS Fargate scheduled task service.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate-scheduled-task/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate-scheduled-task/tree/master)

## Input values

* name_preffix: Name preffix for resources on AWS.
* profile: AWS API key credentials to use.
* region: AWS Region the infrastructure is hosted in.
* ecs_cluster_arn: The ECS Cluster where the scheduled task will run.
* event_rule_name: The rule's name.
* event_rule_description: (Optional) The description of the rule.
* event_rule_schedule_expression: (Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).
* event_rule_event_pattern: (Required, if schedule_expression isn't specified) Event pattern described a JSON object. See full documentation of CloudWatch Events and Event Patterns for details.
* event_rule_role_arn: (Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation.
* event_rule_is_enabled: (Optional) Whether the rule should be enabled (defaults to true).
* event_target_target_id: (Optional) The unique target assignment ID. If missing, will generate a random, unique id.
* event_target_input: (Optional) Valid JSON text passed to the target.
* event_target_input_path: (Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target.
* event_target_ecs_target_task_definition_arn: The ARN of the task definition to use if the event target is an Amazon ECS cluster.
* event_target_ecs_target_subnets: The subnets associated with the task or service.
* event_target_ecs_target_security_groups: (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* event_target_ecs_target_assign_public_ip: (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.
* event_target_ecs_target_task_count: (Optional) The number of tasks to create based on the TaskDefinition. The default is 1.
* event_target_ecs_target_platform_version: (Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0. This is used only if LaunchType is FARGATE.
* event_target_ecs_target_group: (Optional) Specifies an ECS task group for the task. The maximum length is 255 characters.
* ecs_execution_task_role_arn: The task definition execution role

## Output values

* aws_cloudwatch_event_rule_event_rule_arn: The Amazon Resource Name (ARN) of the CloudWatch Event Rule.

