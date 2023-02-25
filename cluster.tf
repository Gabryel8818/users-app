resource "aws_ecs_cluster" "foo" {
  name = "users-app"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
