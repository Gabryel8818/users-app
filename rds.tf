resource "aws_db_instance" "users-app" {
  allocated_storage    = 10
  db_name              = "users_app_db"
  identifier           = "user-app-db"
  engine               = "postgres"
  engine_version       = "14.2"
  instance_class       = "db.t3.micro"
  username             = "users_app"
  password             = random_password.password.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.users-app-db.name
  multi_az             = local.context[terraform.workspace].rds.multi_az
  lifecycle {
    ignore_changes = [
      password
    ]
  }
}

resource "random_password" "password" {
  length  = 12
  special = false
}

resource "aws_db_subnet_group" "users-app-db" {
  name       = "db-subnets"
  subnet_ids = [for subnet in aws_subnet.database : subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}
