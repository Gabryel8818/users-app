resource "aws_ecs_cluster" "app_cluster" {
  name = "users-app"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
