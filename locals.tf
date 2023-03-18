locals {
  rds_secrets = {
      name = aws_db_instance.users-app.db_name 
      password = random_password.password.result
      username = aws_db_instance.users-app.username
  }
  context = {
    stg = {
      subnets_private = "10.0.0.0/20"

      subnets_public = {us-east-1a = "10.0.16.0/20",us-east-1b = "10.0.32.0/20"}

      rds = { multi_az = "false", configs = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)}

      subnets_database = { us-east-1a = "10.0.128.0/24", us-east-1b = "10.0.64.0/24"}

      app_config = { port = 8080, health_check_path = "/ping"}

      capacity_provider = {
        FARGATE = {
          provider = "FARGATE"
          weight   = "50"
          base     = "1"
        }
        FARGATE_SPOT = {
          provider = "FARGATE_SPOT"
          weight   = "50"
          base     = "0"
        }
      }
    }
    sdx = {}
    prd = {}
  }

  tags = {
    env     = terraform.workspace
    project = "users-app"
  }
}
