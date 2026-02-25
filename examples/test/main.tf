# trivy:ignore:AWS-0178 (MEDIUM): VPC does not have VPC Flow Logs enabled.
module "base-network" {
  source  = "cn-terraform/networking/aws"
  version = "4.0.0"

  name_prefix                    = "test"
  vpc_cidr_block                 = "192.168.0.0/16"
  nat_gateway_availability_zones = []

  public_subnets = {
    first-public = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/24"
    }
    second-public = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.1.0/24"
    }
    third-public = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.2.0/24"
    }
    fourth-public = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.3.0/24"
    }
  }

  private_subnets = {
    first-private = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/24"
    }
    second-private = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.129.0/24"
    }
    third-private = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.130.0/24"
    }
    fourth-private = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.131.0/24"
    }
  }
}

# trivy:ignore:AWS-0034 (LOW): Cluster does not have container insights enabled.
module "cluster" {
  source  = "cn-terraform/ecs-cluster/aws"
  version = "2.0.1"
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
  event_target_ecs_cluster_arn                = module.cluster.ecs_cluster.arn
  event_target_ecs_target_subnets             = [for subnet in module.base-network.public_subnets : subnet.id]
  event_target_ecs_target_task_definition_arn = module.td.aws_ecs_task_definition_td_arn
  ecs_execution_task_role_arn                 = "Put your execution role ARN here"
  ecs_task_role_arn                           = "Put your role ARN here"
}
