# AWS ECS Fargate Scheduled Task Terraform Module #

This Terraform module deploys an AWS ECS Fargate scheduled task service.

[![](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)](https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task)

## Usage

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-scheduled-task/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-scheduled-task/aws>

## Other modules that you may need to use this module

The Networking module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

The ECS Cluster module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-cluster/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-cluster/aws>

The ECS Task Definition module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate-task-definition/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate-task-definition/aws>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

        pre-commit install

For that you may need to install the following tools:
* [Pre-commit](https://pre-commit.com/) 
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.ecs_scheduled_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.scheduled_task_cw_event_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.scheduled_task_cw_event_role_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.scheduled_task_cw_event_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.scheduled_task_cw_event_role_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | The ECS Cluster where the scheduled task will run. | `string` | n/a | yes |
| <a name="input_ecs_execution_task_role_arn"></a> [ecs\_execution\_task\_role\_arn](#input\_ecs\_execution\_task\_role\_arn) | (Required) The task definition execution role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. | `string` | n/a | yes |
| <a name="input_ecs_task_role_arn"></a> [ecs\_task\_role\_arn](#input\_ecs\_task\_role\_arn) | (Optional) The task definition role. The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. | `string` | `null` | no |
| <a name="input_event_rule_description"></a> [event\_rule\_description](#input\_event\_rule\_description) | (Optional) The description of the rule. | `string` | `null` | no |
| <a name="input_event_rule_event_bus_name"></a> [event\_rule\_event\_bus\_name](#input\_event\_rule\_event\_bus\_name) | (Optional) The event bus to associate with this rule. If you omit this, the default event bus is used. | `string` | `null` | no |
| <a name="input_event_rule_event_pattern"></a> [event\_rule\_event\_pattern](#input\_event\_rule\_event\_pattern) | (Optional) The event pattern described a JSON object. At least one of schedule\_expression or event\_pattern is required. | `string` | `null` | no |
| <a name="input_event_rule_name"></a> [event\_rule\_name](#input\_event\_rule\_name) | The name of the rule. | `string` | n/a | yes |
| <a name="input_event_rule_role_arn"></a> [event\_rule\_role\_arn](#input\_event\_rule\_role\_arn) | (Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation. | `string` | `null` | no |
| <a name="input_event_rule_schedule_expression"></a> [event\_rule\_schedule\_expression](#input\_event\_rule\_schedule\_expression) | (Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of event\_rule\_schedule\_expression or event\_rule\_event\_pattern is required. Can only be used on the default event bus. | `string` | `null` | no |
| <a name="input_event_rule_state"></a> [event\_rule\_state](#input\_event\_rule\_state) | (Optional) State of the rule. Valid values are DISABLED, ENABLED, and ENABLED\_WITH\_ALL\_CLOUDTRAIL\_MANAGEMENT\_EVENTS. When state is ENABLED, the rule is enabled for all events except those delivered by CloudTrail. To also enable the rule for events delivered by CloudTrail, set state to ENABLED\_WITH\_ALL\_CLOUDTRAIL\_MANAGEMENT\_EVENTS. Defaults to ENABLED. | `string` | `"ENABLED"` | no |
| <a name="input_event_target_ecs_target_assign_public_ip"></a> [event\_target\_ecs\_target\_assign\_public\_ip](#input\_event\_target\_ecs\_target\_assign\_public\_ip) | (Optional) Assign a public IP address to the ENI. Default false. | `bool` | `false` | no |
| <a name="input_event_target_ecs_target_group"></a> [event\_target\_ecs\_target\_group](#input\_event\_target\_ecs\_target\_group) | (Optional) Specifies an ECS task group for the task. The maximum length is 255 characters. | `string` | `null` | no |
| <a name="input_event_target_ecs_target_platform_version"></a> [event\_target\_ecs\_target\_platform\_version](#input\_event\_target\_ecs\_target\_platform\_version) | (Optional) Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0. For more information about valid platform versions, see AWS Fargate Platform Versions. Default to LATEST. | `string` | `"LATEST"` | no |
| <a name="input_event_target_ecs_target_propagate_tags"></a> [event\_target\_ecs\_target\_propagate\_tags](#input\_event\_target\_ecs\_target\_propagate\_tags) | (Optional) Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags are not propagated. Tags can only be propagated to the task during task creation. Valid values: `TASK_DEFINITION` or leave empty to avoid propagation. | `string` | `""` | no |
| <a name="input_event_target_ecs_target_security_groups"></a> [event\_target\_ecs\_target\_security\_groups](#input\_event\_target\_ecs\_target\_security\_groups) | (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used. | `list(any)` | `null` | no |
| <a name="input_event_target_ecs_target_subnets"></a> [event\_target\_ecs\_target\_subnets](#input\_event\_target\_ecs\_target\_subnets) | The subnets associated with the task or service. | `list(any)` | n/a | yes |
| <a name="input_event_target_ecs_target_task_count"></a> [event\_target\_ecs\_target\_task\_count](#input\_event\_target\_ecs\_target\_task\_count) | (Optional) The number of tasks to create based on the TaskDefinition. The default is 1. | `number` | `1` | no |
| <a name="input_event_target_ecs_target_task_definition_arn"></a> [event\_target\_ecs\_target\_task\_definition\_arn](#input\_event\_target\_ecs\_target\_task\_definition\_arn) | (Required) The ARN of the task definition to use if the event target is an Amazon ECS cluster. | `string` | n/a | yes |
| <a name="input_event_target_input"></a> [event\_target\_input](#input\_event\_target\_input) | (Optional) Valid JSON text passed to the target. Conflicts with event\_target\_input\_path. | `string` | `null` | no |
| <a name="input_event_target_input_path"></a> [event\_target\_input\_path](#input\_event\_target\_input\_path) | (Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. Conflicts with event\_target\_input. | `string` | `null` | no |
| <a name="input_event_target_target_id"></a> [event\_target\_target\_id](#input\_event\_target\_target\_id) | (Optional) The unique target assignment ID. If missing, will generate a random, unique id. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for resources on AWS. | `string` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudwatch_event_rule_event_rule_arn"></a> [aws\_cloudwatch\_event\_rule\_event\_rule\_arn](#output\_aws\_cloudwatch\_event\_rule\_event\_rule\_arn) | The Amazon Resource Name (ARN) of the CloudWatch Event Rule. |
| <a name="output_aws_cloudwatch_event_rule_event_rule_id"></a> [aws\_cloudwatch\_event\_rule\_event\_rule\_id](#output\_aws\_cloudwatch\_event\_rule\_event\_rule\_id) | The name of the rule. |
| <a name="output_aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_id"></a> [aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_id](#output\_aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_id) | The role policy ID, in the form of role\_name:role\_policy\_name. |
| <a name="output_aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_name"></a> [aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_name](#output\_aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_name) | The name of the policy. |
| <a name="output_aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_policy"></a> [aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_policy](#output\_aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_policy) | The policy document attached to the role. |
| <a name="output_aws_iam_role_policy_scheduled_task_cw_event_role_cloudwatch_policy_role"></a> [aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_role](#output\_aws\_iam\_role\_policy\_scheduled\_task\_cw\_event\_role\_cloudwatch\_policy\_role) | The name of the role associated with the policy. |
| <a name="output_scheduled_task_cw_event_role_arn"></a> [scheduled\_task\_cw\_event\_role\_arn](#output\_scheduled\_task\_cw\_event\_role\_arn) | The Amazon Resource Name (ARN) specifying the role. |
| <a name="output_scheduled_task_cw_event_role_create_date"></a> [scheduled\_task\_cw\_event\_role\_create\_date](#output\_scheduled\_task\_cw\_event\_role\_create\_date) | The creation date of the IAM role. |
| <a name="output_scheduled_task_cw_event_role_description"></a> [scheduled\_task\_cw\_event\_role\_description](#output\_scheduled\_task\_cw\_event\_role\_description) | The description of the role. |
| <a name="output_scheduled_task_cw_event_role_id"></a> [scheduled\_task\_cw\_event\_role\_id](#output\_scheduled\_task\_cw\_event\_role\_id) | The name of the role. |
| <a name="output_scheduled_task_cw_event_role_name"></a> [scheduled\_task\_cw\_event\_role\_name](#output\_scheduled\_task\_cw\_event\_role\_name) | The name of the role. |
| <a name="output_scheduled_task_cw_event_role_unique_id"></a> [scheduled\_task\_cw\_event\_role\_unique\_id](#output\_scheduled\_task\_cw\_event\_role\_unique\_id) | The stable and unique string identifying the role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
