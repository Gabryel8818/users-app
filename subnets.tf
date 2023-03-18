resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.context[terraform.workspace].subnets_private
  tags = {
    Name = "users-app-private"
  }
}

resource "aws_subnet" "public" {
  for_each          = local.context[terraform.workspace].subnets_public
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    Name = "users-app-public"
  }
}

resource "aws_subnet" "database" {
  for_each          = local.context[terraform.workspace].subnets_database
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "users-app-database"
  }
}
