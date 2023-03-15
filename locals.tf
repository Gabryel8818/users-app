locals {
  context = {
    stg = {
      subnets_public = {
        us-east-1a = "10.0.101.0/25"
        us-east-1b = "10.0.102.0/25"
      }
      app_config = {
        port = 80
        health_check_path = "/"
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
