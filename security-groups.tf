resource "aws_security_group" "alb" {
  name        = "public-users-app"
  description = "Allow ALL inbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "ecs_tasks" {
  name = "users-app-tasks-security-group"
  description = "Allow inbound access from the ALB only"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = local.context[terraform.workspace].app_config.port
    to_port   = local.context[terraform.workspace].app_config.port
    protocol          = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
