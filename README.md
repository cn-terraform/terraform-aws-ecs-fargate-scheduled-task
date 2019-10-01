# AWS ECS Fargate Scheduled Task Terraform Module #

This Terraform module deploys an AWS ECS Fargate scheduled task service.

[![CircleCI](https://circleci.com/gh/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/tree/master.svg?style=svg)](https://circleci.com/gh/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/tree/master)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)

## Usage

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-scheduled-task/aws>

        module "scheduled_task" {
    	    source          = "cn-terraform/ecs-fargate-scheduled-task/aws"
            version         = "1.0.5"
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
            ecs_cluster_arn                             = module.ecs-cluster.aws_ecs_cluster_cluster_arn
            event_rule_name                             = <RULE_NAME>
            ecs_execution_task_role_arn                 = module.td.aws_iam_role_ecs_task_execution_role_arn
            event_rule_schedule_expression              = <SCHEDULE_EXPRESSION>
            event_rule_event_pattern                    = <EVENT_PATTERN>
            event_target_ecs_target_task_definition_arn = module.td.aws_ecs_task_definition_td_arn
            event_target_ecs_target_subnets             = module.networking.private_subnets_ids
    	}

Check the section "Other modules that you may need to use this module" for details about modules mentioned in the usage example.

## Input values

* name_preffix: Name preffix for resources on AWS.
* profile: AWS API key credentials to use.
* region: AWS Region the infrastructure is hosted in.
* ecs_cluster_arn: The ECS Cluster where the scheduled task will run.
* event_rule_name: The rule's name.
* event_target_ecs_target_subnets: The subnets associated with the task or service.
* event_target_ecs_target_task_definition_arn: The ARN of the task definition to use if the event target is an Amazon ECS cluster.
* ecs_execution_task_role_arn: (Required) The task definition execution role.	
* event_rule_schedule_expression: (Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).
* event_rule_event_pattern: (Required, if schedule_expression isn't specified) Event pattern described a JSON object. See full documentation of CloudWatch Events and Event Patterns for details.
* event_rule_description: (Optional) The description of the rule.
* event_rule_role_arn: (Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation.
* event_rule_is_enabled: (Optional) Whether the rule should be enabled (defaults to true).
* event_target_target_id: (Optional) The unique target assignment ID. If missing, will generate a random, unique id.
* event_target_input: (Optional) Valid JSON text passed to the target.
* event_target_input_path: (Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target.
* event_target_ecs_target_security_groups: (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* event_target_ecs_target_assign_public_ip: (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.
* event_target_ecs_target_task_count: (Optional) The number of tasks to create based on the TaskDefinition. The default is 1.
* event_target_ecs_target_platform_version: (Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0. This is used only if LaunchType is FARGATE.
* event_target_ecs_target_group: (Optional) Specifies an ECS task group for the task. The maximum length is 255 characters.

## Output values

* scheduled_task_cw_event_role_arn: The Amazon Resource Name (ARN) specifying the role.
* scheduled_task_cw_event_role_create_date: The creation date of the IAM role.
* scheduled_task_cw_event_role_description: The description of the role.
* scheduled_task_cw_event_role_id: The name of the role.
* scheduled_task_cw_event_role_name: The name of the role.
* scheduled_task_cw_event_role_unique_id: The stable and unique string identifying the role.
* aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_id: The role policy ID, in the form of role_name:role_policy_name.
* aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_name: The name of the policy.
* aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_policy: The policy document attached to the role.
* aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_role: The name of the role associated with the policy.
* aws_cloudwatch_event_rule_event_rule_arn: The Amazon Resource Name (ARN) of the CloudWatch Event Rule.

## Other modules that you may need to use this module

The networking module should look like this:

        module "networking" {
            source          = "cn-terraform/networking/aws"
            version         = "2.0.3"
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
            vpc_cidr_block  = "192.168.0.0/16"
            availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
            public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
            private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
    	}

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

The ECS cluster module should look like this:

        module "ecs-cluster": 
            source       = "cn-terraform/ecs-cluster/aws"
            version      = "1.0.2"
            name_preffix = var.name_preffix
            profile      = var.profile
            region       = var.region
        }

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-cluster/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-cluster/aws>

The task definition module should like this:

        module "td" {
            source          = "cn-terraform/ecs-fargate-task-definition/aws"
            version         = "1.0.0"
            name_preffix    = var.name_preffix
            profile         = var.profile
            region          = var.region
            container_name  = "${var.name_preffix}-<NAME>"
            container_image = "<IMAGE_NAME>:<IMAGE_TAG>"
            container_port  = <PORT>
    	}

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-task-definition/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-task-definition/aws>

