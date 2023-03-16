resource "aws_ecr_repository" "users-app" {
  name                 = "users-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
