resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 512
  memory                   = 1024
  container_definitions = jsonencode([
    {
      name  = "nginx-container"
      image = "nginx:latest"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      memoryReservation = 128
      cpu               = 256
      essential         = true

    }
  ])
}
