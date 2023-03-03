resource "aws_lb" "users-app" {
  name               = "users-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.users-app.arn
  port              = "80"
  protocol          = "HTTP"

  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Ta filezinho papai"
  #     status_code  = "200"
  #   }
  # }

  default_action {
    target_group_arn = aws_alb_target_group.users_app.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "users_app" {
  name        = "users-app-target-group"
  port        = local.app_config.port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = local.app_config.health_check_path
    unhealthy_threshold = "2"
  }
}
