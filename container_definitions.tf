locals {
  container_definitions = jsonencode([
    {
      "name" : "nginx-container",
      "image" : "matheusq94/users-app:v1.0",
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
          "name" : "USERS_APP",
          "valueFrom" : "${aws_secretsmanager_secret.users-app.arn}"
        }
      ]
    },
  ])
}
