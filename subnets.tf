resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/25"

  tags = {
    Name = "users-app-private"
  }
}

resource "aws_subnet" "public" {
  for_each          = local.context[terraform.workspace].subnets_public
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
}
