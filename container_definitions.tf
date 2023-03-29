locals {
  container_definitions = jsonencode([
    {
      "name" : "nginx-container",
      "image" : "nginx:latest",
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : local.context[terraform.workspace].app_config.port,
          "hostPort" : local.context[terraform.workspace].app_config.port,
          "protocol" : "tcp"
        }
      ],
      "requiresCompatibilities" : [
        "FARGATE"
      ],
      "secrets" : [
        {
          "name" : "users-app",
          "valueFrom" : "${aws_secretsmanager_secret.users-app.arn}"
        }
      ]
    },
  ])
}
