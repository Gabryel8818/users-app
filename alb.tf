resource "aws_lb" "users-app" {
  name               = "users-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.users-app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Ta filezinho papai"
      status_code  = "200"
    }
  }
}
