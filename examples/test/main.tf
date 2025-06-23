module "base-network" {
  source  = "cn-terraform/networking/aws"
  version = "3.0.0"

  cidr_block = "192.168.0.0/16"

  public_subnets = {
    first_public_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/19"
    }
    second_public_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.32.0/19"
    }
    third_public_subnet = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.64.0/19"
    }
    fourth_public_subnet = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.96.0/19"
    }
  }

  private_subnets = {
    first_private_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/19"
    }
    second_private_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.160.0/19"
    }
    third_private_subnet = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.192.0/19"
    }
    fourth_private_subnet = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.224.0/19"
    }
  }
}

module "cluster" {
  source  = "cn-terraform/ecs-cluster/aws"
  version = "1.0.7"
  name    = "test-cluster"
}

module "td" {
  source          = "cn-terraform/ecs-fargate-task-definition/aws"
  version         = "1.0.24"
  name_prefix     = "test-td"
  container_image = "ubuntu"
  container_name  = "test"
}

module "task" {
  source                                      = "../../"
  name_prefix                                 = "test-task"
  event_rule_name                             = "test-rule"
  event_rule_schedule_expression              = "cron(0 20 * * ? *)"
  ecs_cluster_arn                             = module.cluster.aws_ecs_cluster_cluster_arn
  event_target_ecs_target_subnets             = [for subnet in module.base-network.public_subnets : subnet.id]
  event_target_ecs_target_task_definition_arn = module.td.aws_ecs_task_definition_td_arn
  ecs_execution_task_role_arn                 = "Put your execution role ARN here"
  ecs_task_role_arn                           = "Put your role ARN here"
}
