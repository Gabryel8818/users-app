resource "aws_ecs_service" "users_app_svc" {
  name            = "users-app-svc"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [aws_subnet.private.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.users_app.id
    container_name   = "nginx-container"
    container_port   = local.app_config.port
  }

  depends_on = [aws_lb_listener.http]
}