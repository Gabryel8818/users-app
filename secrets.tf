resource "aws_secretsmanager_secret" "users-app" {
  name = "users-app-1"
}

resource "aws_secretsmanager_secret_version" "users-app" {
  secret_id     = aws_secretsmanager_secret.users-app.id
  secret_string = jsonencode(local.rds_secrets)
}

