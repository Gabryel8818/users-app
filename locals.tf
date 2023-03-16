locals {
  context = {
    stg = {
      subnets_public = {
        us-east-1a = "10.0.101.0/25"
        us-east-1b = "10.0.102.0/25"
      }
      app_config = {
        port = 8080
        health_check_path = "/ping"
      }
      capacity_provider = {

        FARGATE = {
          provider = "FARGATE"
          weight = "50"
          base = "1"
        }
        FARGATE_SPOT = {
          provider = "FARGATE_SPOT"
          weight = "50"
          base = "0"
        }
      }
    }
    sdx = {}
    prd = {}
  }

  tags = {
    env = terraform.workspace
    project = "users-app"
  }
}
