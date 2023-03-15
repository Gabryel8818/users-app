resource "aws_nat_gateway" "users-app" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public["us-east-1a"].id

  depends_on = [aws_internet_gateway.users-app]
}
