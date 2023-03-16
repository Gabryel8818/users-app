resource "aws_ecs_cluster" "app_cluster" {
  name = "users-app"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "users-app" {
  cluster_name = aws_ecs_cluster.app_cluster.name

  capacity_providers = ["FARGATE_SPOT","FARGATE"]

  dynamic "default_capacity_provider_strategy" {
    for_each = local.context[terraform.workspace].capacity_provider

    content {
    base              = default_capacity_provider_strategy.value.base 
    weight            = default_capacity_provider_strategy.value.weight
    capacity_provider = default_capacity_provider_strategy.value.provider
    }
  }
}
