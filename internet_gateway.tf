resource "aws_internet_gateway" "users-app" {
  vpc_id = aws_vpc.main.id
}
