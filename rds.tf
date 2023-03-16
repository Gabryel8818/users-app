resource "aws_db_instance" "users-app" {
  allocated_storage    = 10
  db_name              = "users-app-db"
  engine               = "postgresql"
  engine_version       = "15.2"
  instance_class       = "db.t3.micro"
  username             = "users-app"
  password             = random_password.password.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.users-app-db.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "@#!"
}

resource "aws_db_subnet_group" "users-app-db" {
  name       = "db-subnets"
  subnet_ids = [for subnet in local.context[terraform.workspace].subnets_database : subnet]

  tags = {
    Name = "My DB subnet group"
  }
}